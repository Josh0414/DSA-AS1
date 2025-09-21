import ballerina/http;
import ballerina/time;

// Asset status enumeration
public enum AssetStatus {
    ACTIVE,
    UNDER_REPAIR,
    DISPOSED
}

// Data structures
public type Component record {
    string componentId;
    string name;
    string description;
    string status;
};

public type MaintenanceSchedule record {
    string scheduleId;
    string description;
    string frequency; // e.g., "quarterly", "yearly"
    string nextDueDate;
    boolean isOverdue;
};

public type Task record {
    string taskId;
    string description;
    string status; // e.g., "pending", "in_progress", "completed"
    string assignedTo?;
};

public type WorkOrder record {
    string workOrderId;
    string description;
    string status; // e.g., "open", "in_progress", "closed"
    string createdDate;
    string priority;
    map<Task> tasks;
};

public type Asset record {
    string assetTag;
    string name;
    string faculty;
    string department;
    AssetStatus status;
    string acquiredDate;
    map<Component> components;
    map<MaintenanceSchedule> schedules;
    map<WorkOrder> workOrders;
};

// In-memory database using map
map<Asset> assetDatabase = {};

// Asset Management Service
service /assets on new http:Listener(8081) {

    // Create a new asset
    resource function post .(@http:Payload Asset asset) returns http:Created|http:BadRequest|http:Conflict {
        if (assetDatabase.hasKey(asset.assetTag)) {
            return http:CONFLICT;
        }
        
        assetDatabase[asset.assetTag] = asset;
        return http:CREATED;
    }

    // Get all assets
    resource function get .() returns Asset[] {
        return assetDatabase.toArray();
    }

    // Get specific asset by tag
    resource function get [string assetTag]() returns Asset|http:NotFound {
        if (assetDatabase.hasKey(assetTag)) {
            return assetDatabase.get(assetTag);
        }
        return http:NOT_FOUND;
    }

    // Update an asset
    resource function put [string assetTag](@http:Payload Asset asset) returns http:Ok|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        asset.assetTag = assetTag; // Ensure consistency
        assetDatabase[assetTag] = asset;
        return http:OK;
    }

    // Delete an asset
    resource function delete [string assetTag]() returns http:NoContent|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        _ = assetDatabase.remove(assetTag);
        return http:NO_CONTENT;
    }

    // Get assets by faculty
    resource function get faculty/[string faculty]() returns Asset[] {
        Asset[] facultyAssets = [];
        
        foreach var asset in assetDatabase {
            if (asset.faculty == faculty) {
                facultyAssets.push(asset);
            }
        }
        
        return facultyAssets;
    }

    // Get overdue maintenance items
    resource function get overdue() returns Asset[] {
        Asset[] overdueAssets = [];
        string currentDate = time:utcToString(time:utcNow());
        
        foreach var asset in assetDatabase {
            boolean hasOverdueSchedule = false;
            
            foreach var schedule in asset.schedules {
                if (isDateOverdue(schedule.nextDueDate, currentDate)) {
                    hasOverdueSchedule = true;
                    break;
                }
            }
            
            if (hasOverdueSchedule) {
                overdueAssets.push(asset);
            }
        }
        
        return overdueAssets;
    }

    // Component management
    resource function post [string assetTag]/components(@http:Payload Component component) returns http:Created|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        asset.components[component.componentId] = component;
        assetDatabase[assetTag] = asset;
        
        return http:CREATED;
    }

    resource function delete [string assetTag]/components/[string componentId]() returns http:NoContent|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        if (!asset.components.hasKey(componentId)) {
            return http:NOT_FOUND;
        }
        
        _ = asset.components.remove(componentId);
        assetDatabase[assetTag] = asset;
        
        return http:NO_CONTENT;
    }

    // Schedule management
    resource function post [string assetTag]/schedules(@http:Payload MaintenanceSchedule schedule) returns http:Created|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        asset.schedules[schedule.scheduleId] = schedule;
        assetDatabase[assetTag] = asset;
        
        return http:CREATED;
    }

    resource function delete [string assetTag]/schedules/[string scheduleId]() returns http:NoContent|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        if (!asset.schedules.hasKey(scheduleId)) {
            return http:NOT_FOUND;
        }
        
        _ = asset.schedules.remove(scheduleId);
        assetDatabase[assetTag] = asset;
        
        return http:NO_CONTENT;
    }

    // Work order management
    resource function post [string assetTag]/workorders(@http:Payload WorkOrder workOrder) returns http:Created|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        asset.workOrders[workOrder.workOrderId] = workOrder;
        assetDatabase[assetTag] = asset;
        
        return http:CREATED;
    }

    resource function put [string assetTag]/workorders/[string workOrderId](@http:Payload WorkOrder workOrder) returns http:Ok|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        if (!asset.workOrders.hasKey(workOrderId)) {
            return http:NOT_FOUND;
        }
        
        workOrder.workOrderId = workOrderId;
        asset.workOrders[workOrderId] = workOrder;
        assetDatabase[assetTag] = asset;
        
        return http:OK;
    }
    // health check
    resource function get health() returns json {
        return { status: "ok", time: time:utcToString(time:utcNow()) };
    }
 

    // Task management under work orders
    resource function post [string assetTag]/workorders/[string workOrderId]/tasks(@http:Payload Task task) returns http:Created|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        if (!asset.workOrders.hasKey(workOrderId)) {
            return http:NOT_FOUND;
        }
        
        WorkOrder workOrder = asset.workOrders.get(workOrderId);
        workOrder.tasks[task.taskId] = task;
        asset.workOrders[workOrderId] = workOrder;
        assetDatabase[assetTag] = asset;
        
        return http:CREATED;    
    }

    resource function delete [string assetTag]/workorders/[string workOrderId]/tasks/[string taskId]() returns http:NoContent|http:NotFound {
        if (!assetDatabase.hasKey(assetTag)) {
            return http:NOT_FOUND;
        }
        
        Asset asset = assetDatabase.get(assetTag);
        if (!asset.workOrders.hasKey(workOrderId)) {
            return http:NOT_FOUND;
        }
        
        WorkOrder workOrder = asset.workOrders.get(workOrderId);
        if (!workOrder.tasks.hasKey(taskId)) {
            return http:NOT_FOUND;
        }
        
        _ = workOrder.tasks.remove(taskId);
        asset.workOrders[workOrderId] = workOrder;
        assetDatabase[assetTag] = asset;
        
        return http:NO_CONTENT;
    }
}

// Helper function to check if a date is overdue
function isDateOverdue(string dueDate, string currentDate) returns boolean {
    // Simple string comparison - in production, you'd use proper date parsing
    return dueDate < currentDate;
}
