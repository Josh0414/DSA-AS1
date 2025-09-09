import ballerina/grpc;
import ballerina/io;
import ballerina/time;
import ballerina/regex;

// Use the same descriptor constant
public const string WT_DESC = "0A0877742E70726F746F22B8010A0343617212140A05706C6174651801200128095205706C61746512120A046D616B6518022001280952046D616B6512140A056D6F64656C18032001280952056D6F64656C12120A0479656172180420012805520479656172121F0A0B6461696C795F7072696365180520012801520A6461696C79507269636512180A076D696C6561676518062001280552076D696C6561676512220A0673746174757318072001280E320A2E436172537461747573520673746174757322680A045573657212170A07757365725F6964180120012809520675736572496412120A046E616D6518022001280952046E616D6512140A05656D61696C1803200128095205656D61696C121D0A04726F6C6518042001280E32092E55736572526F6C655204726F6C65227B0A08436172744974656D12140A05706C6174651801200128095205706C617465121D0A0A73746172745F64617465180220012809520973746172744461746512190A08656E645F646174651803200128095207656E6444617465121F0A0B746F74616C5F7072696365180420012801520A746F74616C507269636522DC010A0B5265736572766174696F6E12250A0E7265736572766174696F6E5F6964180120012809520D7265736572766174696F6E4964121F0A0B637573746F6D65725F6964180220012809520A637573746F6D65724964121F0A056974656D7318032003280B32092E436172744974656D52056974656D7312210A0C746F74616C5F616D6F756E74180420012801520B746F74616C416D6F756E7412290A107265736572766174696F6E5F64617465180520012809520F7265736572766174696F6E4461746512160A06737461747573180620012809520673746174757322270A0D4164644361725265717565737412160A0363617218012001280B32042E436172520363617222400A0E416464436172526573706F6E736512140A05706C6174651801200128095205706C61746512180A076D65737361676518022001280952076D65737361676522540A134372656174655573657273526573706F6E736512180A076D65737361676518012001280952076D65737361676512230A0D75736572735F63726561746564180220012805520C757365727343726561746564224D0A105570646174654361725265717565737412140A05706C6174651801200128095205706C61746512230A0A6361725F75706461746518022001280B32042E436172520963617255706461746522540A11557064617465436172526573706F6E736512180A076D65737361676518012001280952076D65737361676512250A0B757064617465645F63617218022001280B32042E436172520A7570646174656443617222280A1052656D6F76654361725265717565737412140A05706C6174651801200128095205706C61746522450A11536561726368436172526573706F6E736512160A0363617218012001280B32042E436172520363617212180A076D65737361676518022001280952076D6573736167652283010A10416464546F4361727452657175657374121F0A0B637573746F6D65725F6964180120012809520A637573746F6D6572496412140A05706C6174651802200128095205706C617465121D0A0A73746172745F64617465180320012809520973746172744461746512190A08656E645F646174651804200128095207656E644461746522550A11416464546F43617274526573706F6E736512180A076D65737361676518012001280952076D65737361676512260A09636172745F6974656D18022001280B32092E436172744974656D5208636172744974656D223A0A17506C6163655265736572766174696F6E52657175657374121F0A0B637573746F6D65725F6964180120012809520A637573746F6D6572496422640A18506C6163655265736572766174696F6E526573706F6E736512180A076D65737361676518012001280952076D657373616765122E0A0B7265736572766174696F6E18022001280B320C2E5265736572766174696F6E520B7265736572766174696F6E22190A174C6973745265736572766174696F6E7352657175657374224C0A184C6973745265736572766174696F6E73526573706F6E736512300A0C7265736572766174696F6E7318012003280B320C2E5265736572766174696F6E520C7265736572766174696F6E732A370A09436172537461747573120D0A09415641494C41424C451000120F0A0B554E415641494C41424C451001120A0A0652454E54454410022A230A0855736572526F6C65120C0A08435553544F4D4552100012090A0541444D494E10013285040A1043617252656E74616C5365727669636512290A06416464436172120E2E416464436172526571756573741A0F2E416464436172526573706F6E7365122C0A0B437265617465557365727312052E557365721A142E4372656174655573657273526573706F6E7365280112320A0955706461746543617212112E557064617465436172526571756573741A122E557064617465436172526573706F6E736512320A0952656D6F766543617212112E52656D6F7665436172526571756573741A122E52656D6F7665436172526573706F6E736512360A114C697374417661696C61626C654361727312192E4C697374417661696C61626C6543617273526571756573741A042E436172300112320A0953656172636843617212112E536561726368436172526571756573741A122E536561726368436172526573706F6E736512320A09416464546F4361727412112E416464546F43617274526571756573741A122E416464546F43617274526573706F6E736512470A10506C6163655265736572766174696F6E12182E506C6163655265736572766174696F6E526571756573741A192E506C6163655265736572766174696F6E526573706F6E736512470A104C6973745265736572766174696F6E7312182E4C6973745265736572766174696F6E73526571756573741A192E4C6973745265736572766174696F6E73526573706F6E7365620670726F746F33";

// Car status enumeration
public enum CarStatus {
    AVAILABLE = "AVAILABLE",
    UNAVAILABLE = "UNAVAILABLE", 
    RENTED = "RENTED"
}

// User role enumeration
public enum UserRole {
    CUSTOMER = "CUSTOMER",
    ADMIN = "ADMIN"
}

// Data types
public type Car record {
    string plate;
    string make;
    string model;
    int year;
    decimal dailyPrice;
    int mileage;
    CarStatus status;
};

public type User record {
    string userId;
    string name;
    string email;
    UserRole role;
};

public type CartItem record {
    string plate;
    string startDate;
    string endDate;
    decimal totalPrice;
};

public type Reservation record {
    string reservationId;
    string customerId;
    CartItem[] items;
    decimal totalAmount;
    string reservationDate;
    string status;
};

// Request/Response types for gRPC
public type AddCarRequest record {
    Car car;
};

public type AddCarResponse record {
    string plate;
    string message;
};

public type CreateUsersResponse record {
    string message;
    int usersCreated;
};

public type UpdateCarRequest record {
    string plate;
    Car carUpdate;
};

public type UpdateCarResponse record {
    string message;
    Car updatedCar;
};

public type RemoveCarRequest record {
    string plate;
};

public type RemoveCarResponse record {
    string message;
    Car[] remainingCars;
};

public type ListAvailableCarsRequest record {
    string filter;
};

public type SearchCarRequest record {
    string plate;
};

public type SearchCarResponse record {
    Car car;
    string message;
};

public type AddToCartRequest record {
    string customer_id?;
    string? plate;
    string start_date?;
    string end_date?;
};

public type AddToCartResponse record {
    string message;
    CartItem cartItem;
};

public type PlaceReservationRequest record {
    string customerId;
};

public type PlaceReservationResponse record {
    string message;
    Reservation reservation;
};

public type ListReservationsRequest record {
    // Empty request
};

public type ListReservationsResponse record {
    Reservation[] reservations;
};

// In-memory storage
map<Car> carInventory = {};
map<User> users = {};
map<CartItem[]> customerCarts = {}; // customerId -> CartItem[]
map<Reservation> reservations = {};
int reservationCounter = 1;

// gRPC service implementation
@grpc:Descriptor {value: WT_DESC}
service "CarRentalService" on new grpc:Listener(9090) {

    remote function AddCar(AddCarRequest request) returns AddCarResponse|error {
        Car car = request.car;
        // Check if admin operation (simplified - in production, implement proper auth)
        
        if (carInventory.hasKey(car.plate)) {
            return {
                plate: car.plate,
                message: "Car with this plate already exists"
            };
        }
        
        carInventory[car.plate] = car;
        
        return {
            plate: car.plate,
            message: "Car added successfully"
        };
    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        int userCount = 0;
        
        check clientStream.forEach(function(User user) {
            users[user.userId] = user;
            userCount += 1;
        });
        
        return {
            message: "Users created successfully",
            usersCreated: userCount
        };
    }

    remote function UpdateCar(UpdateCarRequest request) returns UpdateCarResponse|error {
        if (!carInventory.hasKey(request.plate)) {
            return error("Car not found");
        }
        
        Car existingCar = carInventory.get(request.plate);
        
        // Update fields if provided
        Car updatedCar = {
            plate: request.plate,
            make: request.carUpdate.make != "" ? request.carUpdate.make : existingCar.make,
            model: request.carUpdate.model != "" ? request.carUpdate.model : existingCar.model,
            year: request.carUpdate.year != 0 ? request.carUpdate.year : existingCar.year,
            dailyPrice: request.carUpdate.dailyPrice != 0.0d ? request.carUpdate.dailyPrice : existingCar.dailyPrice,
            mileage: request.carUpdate.mileage != 0 ? request.carUpdate.mileage : existingCar.mileage,
            status: request.carUpdate.status != "" ? request.carUpdate.status : existingCar.status
        };
        
        carInventory[request.plate] = updatedCar;
        
        return {
            message: "Car updated successfully",
            updatedCar: updatedCar
        };
    }

    remote function RemoveCar(RemoveCarRequest request) returns RemoveCarResponse|error {
        string plate = request.plate;
        if (!carInventory.hasKey(plate)) {
            return error("Car not found");
        }
        
        _ = carInventory.remove(plate);
        
        return {
            message: "Car removed successfully",
            remainingCars: carInventory.toArray()
        };
    }

    remote function ListAvailableCars(ListAvailableCarsRequest request) returns stream<Car, error?>|error {
        Car[] availableCars = [];
        
        foreach var car in carInventory {
            if (car.status == AVAILABLE) {
                availableCars.push(car);
            }
        }
        
        return availableCars.toStream();
    }

    remote function SearchCar(SearchCarRequest request) returns SearchCarResponse|error {
        string plate = request.plate;
        if (!carInventory.hasKey(plate)) {
            return {
                car: {
                    plate: "",
                    make: "",
                    model: "",
                    year: 0,
                    dailyPrice: 0,
                    mileage: 0,
                    status: UNAVAILABLE
                },
                message: "Car not found"
            };
        }
        
        Car car = carInventory.get(plate);
        
        if (car.status != AVAILABLE) {
            return {
                car: car,
                message: "Car is not available for rent"
            };
        }
        
        return {
            car: car,
            message: "Car is available"
        };
    }

    remote function AddToCart(AddToCartRequest request) returns AddToCartResponse|error {
        // Debug logging
        io:println("DEBUG: Received AddToCart request");
        io:println("DEBUG: customer_id = " + (request.customer_id ?: "null"));
        io:println("DEBUG: plate = " + (request.plate ?: "null"));
        io:println("DEBUG: start_date = " + (request.start_date ?: "null"));
        io:println("DEBUG: end_date = " + (request.end_date ?: "null"));
        
        // Validate car exists and is available
        if (request.plate is () || !carInventory.hasKey(request.plate ?: "")) {
            return error("Car not found");
        }
        
        Car car = carInventory.get(request.plate ?: "");
        if (car.status != AVAILABLE) {
            return error("Car is not available");
        }
        
        // Validate dates - improved date validation
        if (!isValidDateRange(request.start_date, request.end_date)) {
            return error("Invalid rental dates: start date must be before end date");
        }
        
        // Calculate price 
        int days = calculateRentalDays(request.start_date ?: "", request.end_date ?: "");
        if (days <= 0) {
            return error("Invalid rental period: must be at least 1 day");
        }
        decimal totalPrice = car.dailyPrice * days;
        
        CartItem cartItem = {
            plate: request.plate ?: "",
            startDate: request.start_date ?: "",
            endDate: request.end_date ?: "",
            totalPrice: totalPrice
        };
        
        // Add to customer's cart
        if (request.customer_id is () || !customerCarts.hasKey(request.customer_id ?: "")) {
            customerCarts[request.customer_id ?: ""] = [];
        }
        
        CartItem[] cart = customerCarts.get(request.customer_id ?: "");
        cart.push(cartItem);
        customerCarts[request.customer_id ?: ""] = cart;
        
        return {
            message: "Item added to cart successfully",
            cartItem: cartItem
        };
    }

    remote function PlaceReservation(PlaceReservationRequest request) returns PlaceReservationResponse|error {
        string customerId = request.customerId;
        if (!customerCarts.hasKey(customerId)) {
            return error("No items in cart");
        }
        
        CartItem[] cart = customerCarts.get(customerId);
        if (cart.length() == 0) {
            return error("Cart is empty");
        }
        
        // Validate all cars are still available
        foreach var item in cart {
            if (!carInventory.hasKey(item.plate)) {
                return error("Car " + item.plate + " no longer exists");
            }
            
            Car car = carInventory.get(item.plate);
            if (car.status != AVAILABLE) {
                return error("Car " + item.plate + " is no longer available");
            }
        }
        
        // Calculate total amount
        decimal totalAmount = 0;
        foreach var item in cart {
            totalAmount += item.totalPrice;
        }
        
        // Create reservation
        string reservationId = "RES-" + reservationCounter.toString();
        reservationCounter += 1;
        
        Reservation reservation = {
            reservationId: reservationId,
            customerId: customerId,
            items: cart,
            totalAmount: totalAmount,
            reservationDate: time:utcToString(time:utcNow()),
            status: "CONFIRMED"
        };
        
        // Mark cars as rented
        foreach var item in cart {
            Car car = carInventory.get(item.plate);
            car.status = RENTED;
            carInventory[item.plate] = car;
        }
        
        // Store reservation and clear cart
        reservations[reservationId] = reservation;
        customerCarts[customerId] = [];
        
        return {
            message: "Reservation placed successfully",
            reservation: reservation
        };
    }

    remote function ListReservations(ListReservationsRequest request) returns ListReservationsResponse|error {
        return {reservations: reservations.toArray()};
    }
}

// Helper function to validate date range
function isValidDateRange(string? startDate, string? endDate) returns boolean {
    // Check for null or empty strings
    if (startDate is () || endDate is () || startDate == "" || endDate == "") {
        return false;
    }
    
    // Basic date format validation for YYYY-MM-DD
    if (startDate.length() != 10 || endDate.length() != 10) {
        return false;
    }
    
    // Check for correct format (basic check for dashes in right positions)
    if (startDate[4] != "-" || startDate[7] != "-" || 
        endDate[4] != "-" || endDate[7] != "-") {
        return false;
    }
    
    // Simple string comparison should work for YYYY-MM-DD format
    // since it's lexicographically comparable
    return startDate < endDate;
}

// Helper function to calculate rental days (improved)
function calculateRentalDays(string startDate, string endDate) returns int {
    // Check for empty strings
    if (startDate == "" || endDate == "") {
        return 3; // Default for demo
    }
    
    // For demonstration purposes, we'll parse the dates and calculate difference
    // In a real application, you'd use proper date/time libraries
    
    // Extract year, month, day from YYYY-MM-DD format
    string[] startParts = regex:split(startDate, "-");
    string[] endParts = regex:split(endDate, "-");
    
    if (startParts.length() != 3 || endParts.length() != 3) {
        return 1; // Default to 1 day if parsing fails
    }
    
    int|error startYear = int:fromString(startParts[0]);
    int|error startMonth = int:fromString(startParts[1]);
    int|error startDay = int:fromString(startParts[2]);
    
    int|error endYear = int:fromString(endParts[0]);
    int|error endMonth = int:fromString(endParts[1]);
    int|error endDay = int:fromString(endParts[2]);
    
    // If parsing fails, return default
    if (startYear is error || startMonth is error || startDay is error ||
        endYear is error || endMonth is error || endDay is error) {
        return 3; // Default to 3 days for demo
    }
    
    // Simple calculation (not accounting for month lengths, leap years, etc.)
    // This is a simplified approach for demonstration
    int startDays = startYear * 365 + startMonth * 30 + startDay;
    int endDays = endYear * 365 + endMonth * 30 + endDay;
    
    int difference = endDays - startDays;
    return difference > 0 ? difference : 1; // At least 1 day
}

public function main() returns error? {
    // Initialize some sample data
    initializeSampleData();
    
    io:println("Car Rental gRPC Server started on port 9090");
    io:println("Waiting for client connections...");
}

function initializeSampleData() {
    // Add sample cars
    carInventory["ABC-123"] = {
        plate: "ABC-123",
        make: "Toyota",
        model: "Camry",
        year: 2022,
        dailyPrice: 45.00,
        mileage: 15000,
        status: AVAILABLE
    };
    
    carInventory["XYZ-789"] = {
        plate: "XYZ-789", 
        make: "Honda",
        model: "Accord",
        year: 2021,
        dailyPrice: 42.00,
        mileage: 22000,
        status: AVAILABLE
    };
    
    carInventory["DEF-456"] = {
        plate: "DEF-456",
        make: "BMW",
        model: "X3",
        year: 2023,
        dailyPrice: 75.00,
        mileage: 8000,
        status: UNAVAILABLE
    };
    
    // Add sample users
    users["customer1"] = {
        userId: "customer1",
        name: "John Doe",
        email: "john.doe@example.com",
        role: CUSTOMER
    };
    
    users["admin1"] = {
        userId: "admin1", 
        name: "Jane Smith",
        email: "jane.smith@company.com",
        role: ADMIN
    };
    
    io:println("Sample data initialized:");
    io:println("- Cars: " + carInventory.keys().length().toString());
    io:println("- Users: " + users.keys().length().toString());
}
