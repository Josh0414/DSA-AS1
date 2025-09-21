import ballerina/http;
import ballerina/io;

// Client configuration
http:Client assetClient = check new("http://localhost:8081");
// Reusable HTTP client pointing to our service root (base URL). 'check' aborts main on init error.
public function main() returns error? {
    io:println("=== Asset Management System Client Demo ===\n");
    
    // 1. Create sample assets
    check createSampleAssets();
    
    // 2. View all assets
    check viewAllAssets();
    
    // 3. View assets by faculty
    check viewAssetsByFaculty("Computing & Informatics");
    
    // 4. Add components to an asset
    check addComponentToAsset();
    
    // 5. Add maintenance schedule
    check addMaintenanceSchedule();
    
    // 6. Check overdue items
    check checkOverdueItems();
    
    // 7. Update asset
    check updateAssetDemo();
    
    // 8. Demonstrate work orders
    check addWorkOrderDemo();
    
    io:println("\n=== Demo completed successfully! ===");
}

function createSampleAssets() returns error? {
    io:println("1. Creating sample assets...");
    
    // Create first asset
    json asset1 = {
        "assetTag": "EQ-001",
        "name": "3D Printer",
        "faculty": "Computing & Informatics",
        "department": "Software Engineering",
        "status": "ACTIVE",
        "acquiredDate": "2024-03-10",
        "components": {},
        "schedules": {},
        "workOrders": {}
    };
    
    http:Response response1 = check assetClient->post("/assets", asset1);
    io:println("Created asset EQ-001: " + response1.statusCode.toString());
    
    // Create second asset
    json asset2 = {
        "assetTag": "EQ-002",
        "name": "Server Dell R740",
        "faculty": "Computing & Informatics",
        "department": "Information Technology",
        "status": "ACTIVE",
        "acquiredDate": "2023-11-15",
        "components": {},
        "schedules": {},
        "workOrders": {}
    };
    
    http:Response response2 = check assetClient->post("/assets", asset2);
    io:println("Created asset EQ-002: " + response2.statusCode.toString());
    
    // Create third asset for different faculty
    json asset3 = {
        "assetTag": "VH-001",
        "name": "Research Vehicle",
        "faculty": "Engineering",
        "department": "Mechanical Engineering",
        "status": "ACTIVE",
        "acquiredDate": "2024-01-20",
        "components": {},
        "schedules": {},
        "workOrders": {}
    };
    
    http:Response response3 = check assetClient->post("/assets", asset3);
    io:println("Created asset VH-001: " + response3.statusCode.toString());
    
    io:println("✓ Sample assets created successfully!\n");
}

function viewAllAssets() returns error? {
    io:println("2. Viewing all assets...");
    
    // Retrieves all assets from the service as a JSON array
    json response = check assetClient->get("/assets");
    io:println("All assets:");
    io:println(response.toJsonString());
    io:println("✓ Successfully retrieved all assets!\n");
}

function viewAssetsByFaculty(string faculty) returns error? {
    io:println("3. Viewing assets by faculty: " + faculty);
    
    // URL encode the faculty name manually for spaces and ampersands
    string encodedFaculty = "Computing%20%26%20Informatics";
    json response = check assetClient->get("/assets/faculty/" + encodedFaculty);
    io:println("Assets in " + faculty + ":");
    io:println(response.toJsonString());
    io:println("✓ Successfully filtered assets by faculty!\n");
}

function addComponentToAsset() returns error? {
    io:println("4. Adding component to asset EQ-001...");
    
    json component = {
        "componentId": "COMP-001",
        "name": "Print Head",
        "description": "Main printing mechanism",
        "status": "ACTIVE"
    };
    
    http:Response response = check assetClient->post("/assets/EQ-001/components", component);
    io:println("Added component: " + response.statusCode.toString());
    
    // Add another component
    json component2 = {
        "componentId": "COMP-002",
        "name": "Extruder Motor",
        "description": "Motor for filament extrusion",
        "status": "ACTIVE"
    };
    
    http:Response response2 = check assetClient->post("/assets/EQ-001/components", component2);
    io:println("Added second component: " + response2.statusCode.toString());
    io:println("✓ Successfully added components!\n");
}

function addMaintenanceSchedule() returns error? {
    io:println("5. Adding maintenance schedule...");
    
    json schedule = {
        "scheduleId": "MAINT-001",
        "description": "Quarterly cleaning and calibration",
        "frequency": "quarterly",
        "nextDueDate": "2025-08-01",
        "isOverdue": true
    };
    
    http:Response response = check assetClient->post("/assets/EQ-001/schedules", schedule);
    io:println("Added schedule: " + response.statusCode.toString());
    
    // Add overdue schedule to server
    json overdueSchedule = {
        "scheduleId": "MAINT-002",
        "description": "Annual hardware inspection",
        "frequency": "yearly", 
        "nextDueDate": "2025-07-01",
        "isOverdue": true
    };
    
    http:Response response2 = check assetClient->post("/assets/EQ-002/schedules", overdueSchedule);
    io:println("Added overdue schedule to EQ-002: " + response2.statusCode.toString());
    io:println("✓ Successfully added maintenance schedules!\n");
}

function checkOverdueItems() returns error? {
    io:println("6. Checking for overdue maintenance items...");
    
    json response = check assetClient->get("/assets/overdue");
    io:println("Overdue assets:");
    io:println(response.toJsonString());
    io:println("✓ Successfully retrieved overdue items!\n");
}

function updateAssetDemo() returns error? {
    io:println("7. Updating asset status...");
    
    // First get the current asset
    json currentAsset = check assetClient->get("/assets/EQ-001");
    
    // Extract the nested objects safely
    json components = {};
    json schedules = {};  
    json workOrders = {};
    
    if (currentAsset is map<json>) {
        components = currentAsset["components"] ?: {};
        schedules = currentAsset["schedules"] ?: {};
        workOrders = currentAsset["workOrders"] ?: {};
    }
    
    // Create a new JSON object with updated status
    json updatedAsset = {
        "assetTag": "EQ-001",
        "name": "3D Printer",
        "faculty": "Computing & Informatics",
        "department": "Software Engineering",
        "status": "UNDER_REPAIR",
        "acquiredDate": "2024-03-10",
        "components": components,
        "schedules": schedules,
        "workOrders": workOrders
    };
    
    http:Response response = check assetClient->put("/assets/EQ-001", updatedAsset);
    io:println("Updated asset EQ-001 status: " + response.statusCode.toString());
    
    // Verify the update
    json verifyAsset = check assetClient->get("/assets/EQ-001");
    io:println("Updated asset details:");
    io:println(verifyAsset.toJsonString());
    io:println("✓ Successfully updated asset!\n");
}

function addWorkOrderDemo() returns error? {
    io:println("8. Adding work order to asset EQ-001...");
    
    json workOrder = {
        "workOrderId": "WO-001",
        "description": "Replace print head due to wear",
        "status": "open",
        "createdDate": "2025-09-03",
        "priority": "high",
        "tasks": {}
    };
    
    http:Response response = check assetClient->post("/assets/EQ-001/workorders", workOrder);
    io:println("Added work order: " + response.statusCode.toString());
    
    // Add a task to the work order
    json task = {
        "taskId": "TASK-001",
        "description": "Remove old print head",
        "status": "pending",
        "assignedTo": "Technician John"
    };
    
    http:Response taskResponse = check assetClient->post("/assets/EQ-001/workorders/WO-001/tasks", task);
    io:println("Added task to work order: " + taskResponse.statusCode.toString());
    io:println("✓ Successfully added work order and task!\n");
}
