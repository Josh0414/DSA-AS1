import ballerina/grpc;
import ballerina/io;

// Use the client stub types directly
public const string WT_DESC = "0A0877742E70726F746F22B8010A0343617212140A05706C6174651801200128095205706C61746512120A046D616B6518022001280952046D616B6512140A056D6F64656C18032001280952056D6F64656C12120A0479656172180420012805520479656172121F0A0B6461696C795F7072696365180520012801520A6461696C79507269636512180A076D696C6561676518062001280552076D696C6561676512220A0673746174757318072001280E320A2E436172537461747573520673746174757322680A045573657212170A07757365725F6964180120012809520675736572496412120A046E616D6518022001280952046E616D6512140A05656D61696C1803200128095205656D61696C121D0A04726F6C6518042001280E32092E55736572526F6C655204726F6C65227B0A08436172744974656D12140A05706C6174651801200128095205706C617465121D0A0A73746172745F64617465180220012809520973746172744461746512190A08656E645F646174651803200128095207656E6444617465121F0A0B746F74616C5F7072696365180420012801520A746F74616C507269636522DC010A0B5265736572766174696F6E12250A0E7265736572766174696F6E5F6964180120012809520D7265736572766174696F6E4964121F0A0B637573746F6D65725F6964180220012809520A637573746F6D65724964121F0A056974656D7318032003280B32092E436172744974656D52056974656D7312210A0C746F74616C5F616D6F756E74180420012801520B746F74616C416D6F756E7412290A107265736572766174696F6E5F64617465180520012809520F7265736572766174696F6E4461746512160A06737461747573180620012809520673746174757322270A0D4164644361725265717565737412160A0363617218012001280B32042E436172520363617222400A0E416464436172526573706F6E736512140A05706C6174651801200128095205706C61746512180A076D65737361676518022001280952076D65737361676522540A134372656174655573657273526573706F6E736512180A076D65737361676518012001280952076D65737361676512230A0D75736572735F63726561746564180220012805520C757365727343726561746564224D0A105570646174654361725265717565737412140A05706C6174651801200128095205706C61746512230A0A6361725F75706461746518022001280B32042E436172520963617255706461746522540A11557064617465436172526573706F6E736512180A076D65737361676518012001280952076D65737361676512250A0B757064617465645F63617218022001280B32042E436172520A7570646174656443617222280A1052656D6F76654361725265717565737412140A05706C6174651801200128095205706C61746522450A11536561726368436172526573706F6E736512160A0363617218012001280B32042E436172520363617212180A076D65737361676518022001280952076D6573736167652283010A10416464546F4361727452657175657374121F0A0B637573746F6D65725F6964180120012809520A637573746F6D6572496412140A05706C6174651802200128095205706C617465121D0A0A73746172745F64617465180320012809520973746172744461746512190A08656E645F646174651804200128095207656E644461746522550A11416464546F43617274526573706F6E736512180A076D65737361676518012001280952076D65737361676512260A09636172745F6974656D18022001280B32092E436172744974656D5208636172744974656D223A0A17506C6163655265736572766174696F6E52657175657374121F0A0B637573746F6D65725F6964180120012809520A637573746F6D6572496422640A18506C6163655265736572766174696F6E526573706F6E736512180A076D65737361676518012001280952076D657373616765122E0A0B7265736572766174696F6E18022001280B320C2E5265736572766174696F6E520B7265736572766174696F6E22190A174C6973745265736572766174696F6E7352657175657374224C0A184C6973745265736572766174696F6E73526573706F6E736512300A0C7265736572766174696F6E7318012003280B320C2E5265736572766174696F6E520C7265736572766174696F6E732A370A09436172537461747573120D0A09415641494C41424C451000120F0A0B554E415641494C41424C451001120A0A0652454E54454410022A230A0855736572526F6C65120C0A08435553544F4D4552100012090A0541444D494E10013285040A1043617252656E74616C5365727669636512290A06416464436172120E2E416464436172526571756573741A0F2E416464436172526573706F6E7365122C0A0B437265617465557365727312052E557365721A142E4372656174655573657273526573706F6E7365280112320A0955706461746543617212112E557064617465436172526571756573741A122E557064617465436172526573706F6E736512320A0952656D6F766543617212112E52656D6F7665436172526571756573741A122E52656D6F7665436172526573706F6E736512360A114C697374417661696C61626C654361727312192E4C697374417661696C61626C6543617273526571756573741A042E436172300112320A0953656172636843617212112E536561726368436172526571756573741A122E536561726368436172526573706F6E736512320A09416464546F4361727412112E416464546F43617274526571756573741A122E416464546F43617274526573706F6E736512470A10506C6163655265736572766174696F6E12182E506C6163655265736572766174696F6E526571756573741A192E506C6163655265736572766174696F6E526573706F6E736512470A104C6973745265736572766174696F6E7312182E4C6973745265736572766174696F6E73526571756573741A192E4C6973745265736572766174696F6E73526573706F6E7365620670726F746F33";

// Car status enumeration
public enum CarStatus {
    AVAILABLE,
    UNAVAILABLE, 
    RENTED
}

// User role enumeration  
public enum UserRole {
    CUSTOMER,
    ADMIN
}

// Client stub - simplified version of what would be generated
public isolated client class CarRentalServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, WT_DESC);
    }

    isolated remote function AddCar(AddCarRequest req) returns AddCarResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/AddCar", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddCarResponse>result;
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("CarRentalService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }

    isolated remote function UpdateCar(UpdateCarRequest req) returns UpdateCarResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/UpdateCar", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateCarResponse>result;
    }

    isolated remote function RemoveCar(RemoveCarRequest req) returns RemoveCarResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/RemoveCar", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveCarResponse>result;
    }

    isolated remote function ListAvailableCars(ListAvailableCarsRequest req) returns stream<Car, grpc:Error?>|grpc:Error {
        var payload = check self.grpcClient->executeServerStreaming("CarRentalService/ListAvailableCars", req, {});
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        CarStream outputStream = new CarStream(result);
        return new stream<Car, grpc:Error?>(outputStream);
    }

    isolated remote function SearchCar(SearchCarRequest req) returns SearchCarResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/SearchCar", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchCarResponse>result;
    }

    isolated remote function AddToCart(AddToCartRequest req) returns AddToCartResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/AddToCart", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddToCartResponse>result;
    }

    isolated remote function PlaceReservation(PlaceReservationRequest req) returns PlaceReservationResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/PlaceReservation", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <PlaceReservationResponse>result;
    }

    isolated remote function ListReservations(ListReservationsRequest req) returns ListReservationsResponse|grpc:Error {
        var payload = check self.grpcClient->executeSimpleRPC("CarRentalService/ListReservations", req, {});
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListReservationsResponse>result;
    }
}

// Streaming client for CreateUsers
public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

// Car stream for server streaming
public class CarStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Car value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if streamValue is () {
            return streamValue;
        } else if streamValue is grpc:Error {
            return streamValue;
        } else {
            record {|Car value;|} nextRecord = {value: <Car>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

// Data types
public type Car record {|
    string plate = "";
    string make = "";
    string model = "";
    int year = 0;
    decimal dailyPrice = 0.0;
    int mileage = 0;
    CarStatus status = AVAILABLE;
|};

public type User record {|
    string userId = "";
    string name = "";
    string email = "";
    UserRole role = CUSTOMER;
|};

public type CartItem record {|
    string plate = "";
    string start_date = "";
    string end_date = "";
    decimal total_price = 0.0;
|};

public type Reservation record {|
    string reservationId = "";
    string customerId = "";
    CartItem[] items = [];
    decimal totalAmount = 0.0;
    string reservationDate = "";
    string status = "";
|};

// Request/Response types
public type AddCarRequest record {|
    Car car = {};
|};

public type AddCarResponse record {|
    string plate = "";
    string message = "";
|};

public type CreateUsersResponse record {|
    string message = "";
    int users_created = 0;
|};

public type UpdateCarRequest record {|
    string plate = "";
    Car car_update = {};
|};

public type UpdateCarResponse record {|
    string message = "";
    Car updated_car = {};
|};

public type RemoveCarRequest record {|
    string plate = "";
|};

public type RemoveCarResponse record {|
    string message = "";
    Car[] remaining_cars = [];
|};

public type ListAvailableCarsRequest record {|
    string filter = "";
|};

public type SearchCarRequest record {|
    string plate = "";
|};

public type SearchCarResponse record {|
    Car car = {};
    string message = "";
|};

public type AddToCartRequest record {|
    string customer_id = "";
    string plate = "";
    string start_date = "";
    string end_date = "";
|};

public type AddToCartResponse record {|
    string message = "";
    CartItem cart_item = {};
|};

public type PlaceReservationRequest record {|
    string customerId = "";
|};

public type PlaceReservationResponse record {|
    string message = "";
    Reservation reservation = {};
|};

public type ListReservationsRequest record {|
|};

public type ListReservationsResponse record {|
    Reservation[] reservations = [];
|};

// Client configuration
CarRentalServiceClient carRentalClient = check new("http://localhost:9090");

public function main() returns error? {
    io:println("=== Car Rental System gRPC Client Demo ===\n");
    
    // 1. Create users (streaming)
    check createUsersDemo();
    
    // 2. Admin operations - Add cars
    check addCarsDemo();
    
    // 3. Customer operations - List available cars (streaming)
    check listAvailableCarsDemo();
    
    // 4. Customer operations - Search for specific car
    check searchCarDemo();
    
    // 5. Customer operations - Add cars to cart
    check addToCartDemo();
    
    // 6. Customer operations - Place reservation
    check placeReservationDemo();
    
    // 7. Admin operations - Update car
    check updateCarDemo();
    
    // 8. Admin operations - List all reservations
    check listReservationsDemo();
    
    // 9. Admin operations - Remove car
    check removeCarDemo();
    
    io:println("\n=== Car Rental Client Demo completed successfully! ===");
}

// Demo function 1: Create multiple users using client streaming
function createUsersDemo() returns error? {
    io:println("1. Creating multiple users via streaming...");
    
    // Get streaming client
    CreateUsersStreamingClient streamingClient = check carRentalClient->CreateUsers();
    
    // Create and send multiple users
    User customer1 = {
        userId: "customer001",
        name: "Alice Johnson",
        email: "alice.johnson@email.com",
        role: CUSTOMER
    };
    
    User customer2 = {
        userId: "customer002", 
        name: "Bob Smith",
        email: "bob.smith@email.com",
        role: CUSTOMER
    };
    
    User admin1 = {
        userId: "admin001",
        name: "Carol Admin",
        email: "carol.admin@company.com",
        role: ADMIN
    };
    
    // Send users to server
    check streamingClient->sendUser(customer1);
    io:println("Sent customer: " + customer1.name);
    
    check streamingClient->sendUser(customer2);
    io:println("Sent customer: " + customer2.name);
    
    check streamingClient->sendUser(admin1);
    io:println("Sent admin: " + admin1.name);
    
    // Complete the streaming and get response
    check streamingClient->complete();
    CreateUsersResponse|grpc:Error? response = streamingClient->receiveCreateUsersResponse();
    
    if response is CreateUsersResponse {
        io:println("✓ " + response.message + " (Total: " + response.users_created.toString() + " users)\n");
    } else if response is grpc:Error {
        io:println("✗ Error receiving response: " + response.message() + "\n");
    } else {
        io:println("✗ No response received\n");
    }
}

// Demo function 2: Admin adds cars to the system
function addCarsDemo() returns error? {
    io:println("2. Admin adding cars to the system...");
    
    // Add first car
    Car car1 = {
        plate: "N 6289 W",
        make: "Toyota",
        model: "Hilux",
        year: 2023,
        dailyPrice: 85.00,
        mileage: 5000,
        status: AVAILABLE
    };
    
    AddCarRequest request1 = {car: car1};
    AddCarResponse response1 = check carRentalClient->AddCar(request1);
    io:println("Added car " + response1.plate + ": " + response1.message);
    
    // Add second car
    Car car2 = {
        plate: "N 346273 W",
        make: "Nissan",
        model: "Navara",
        year: 2022,
        dailyPrice: 75.00,
        mileage: 12000,
        status: AVAILABLE
    };
    
    AddCarRequest request2 = {car: car2};
    AddCarResponse response2 = check carRentalClient->AddCar(request2);
    io:println("Added car " + response2.plate + ": " + response2.message);
    
    // Add luxury car
    Car car3 = {
        plate: "N 5673576 S",
        make: "BMW",
        model: "X5",
        year: 2024,
        dailyPrice: 150.00,
        mileage: 2000,
        status: AVAILABLE
    };
    
    AddCarRequest request3 = {car: car3};
    AddCarResponse response3 = check carRentalClient->AddCar(request3);
    io:println("Added luxury car " + response3.plate + ": " + response3.message);
    
    io:println("✓ Successfully added all cars!\n");
}

// Demo function 3: Customer lists available cars with streaming
function listAvailableCarsDemo() returns error? {
    io:println("3. Listing all available cars (server streaming)...");
    
    ListAvailableCarsRequest request = {filter: ""};
    stream<Car, grpc:Error?> carStream = check carRentalClient->ListAvailableCars(request);
    
    io:println("Available cars:");
    io:println("===============");
    
    error? result = carStream.forEach(function(Car car) {
        io:println("Plate: " + car.plate + " | " + 
                  car.make + " " + car.model + " (" + car.year.toString() + ") | " +
                  "Rate: $" + car.dailyPrice.toString() + "/day | " +
                  "Mileage: " + car.mileage.toString() + "km");
    });
    
    if result is error {
        io:println("Error streaming cars: " + result.message());
    }
    
    io:println("✓ Successfully retrieved available cars!\n");
    
    // Also demo filtering
    io:println("3b. Filtering cars by 'Toyota'...");
    ListAvailableCarsRequest filterRequest = {filter: "Toyota"};
    stream<Car, grpc:Error?> filteredCarStream = check carRentalClient->ListAvailableCars(filterRequest);
    
    error? filterResult = filteredCarStream.forEach(function(Car car) {
        io:println("Filtered: " + car.make + " " + car.model + " (" + car.plate + ")");
    });
    
    if filterResult is error {
        io:println("Error filtering cars: " + filterResult.message());
    }
    
    io:println("✓ Successfully filtered cars!\n");
}

// Demo function 4: Customer searches for specific car
function searchCarDemo() returns error? {
    io:println("4. Customer searching for specific cars...");
    
    // Search for available car
    SearchCarRequest searchRequest1 = {plate: "N 6289 W"};
    SearchCarResponse searchResponse1 = check carRentalClient->SearchCar(searchRequest1);
    
    io:println("Searching for N 6289 W: " + searchResponse1.message);
    if searchResponse1.car.plate != "" {
        io:println("Found: " + searchResponse1.car.make + " " + searchResponse1.car.model + 
                  " - $" + searchResponse1.car.dailyPrice.toString() + "/day");
    }
    
    // Search for non-existent car
    SearchCarRequest searchRequest2 = {plate: "N 9999 S"};
    SearchCarResponse searchResponse2 = check carRentalClient->SearchCar(searchRequest2);
    io:println("Searching for N 9999 S: " + searchResponse2.message);
    
    io:println("✓ Successfully completed car searches!\n");
}

// Demo function 5: Customer adds cars to cart
function addToCartDemo() returns error? {
    io:println("5. Customer adding cars to rental cart...");
    
    // Add first car to cart
    AddToCartRequest cartRequest1 = {
        customer_id: "customer001",
        plate: "N 6289 W",
        start_date: "2025-09-15",
        end_date: "2025-09-18"
    };
    
    AddToCartResponse cartResponse1 = check carRentalClient->AddToCart(cartRequest1);
    io:println("Added to cart: " + cartResponse1.message);
    io:println("Cart item: " + cartResponse1.cart_item.plate + 
              " from " + cartResponse1.cart_item.start_date + 
              " to " + cartResponse1.cart_item.end_date + 
              " - Total: $" + cartResponse1.cart_item.total_price.toString());
    
    // Add second car to cart
    AddToCartRequest cartRequest2 = {
        customer_id: "customer001",
        plate: "N 5673576 S", 
        start_date: "2025-09-20",
        end_date: "2025-09-22"
    };
    
    AddToCartResponse cartResponse2 = check carRentalClient->AddToCart(cartRequest2);
    io:println("Added to cart: " + cartResponse2.message);
    io:println("Cart item: " + cartResponse2.cart_item.plate + 
              " from " + cartResponse2.cart_item.start_date + 
              " to " + cartResponse2.cart_item.end_date + 
              " - Total: $" + cartResponse2.cart_item.total_price.toString());
    
    io:println("✓ Successfully added cars to customer cart!\n");
}

// Demo function 6: Customer places reservation
function placeReservationDemo() returns error? {
    io:println("6. Customer placing reservation...");
    
    PlaceReservationRequest reservationRequest = {customerId: "customer001"};
    PlaceReservationResponse reservationResponse = check carRentalClient->PlaceReservation(reservationRequest);
    
    io:println("Reservation result: " + reservationResponse.message);
    if reservationResponse.reservation.reservationId != "" {
        Reservation reservation = reservationResponse.reservation;
        io:println("Reservation Details:");
        io:println("- ID: " + reservation.reservationId);
        io:println("- Customer: " + reservation.customerId);
        io:println("- Date: " + reservation.reservationDate);
        io:println("- Status: " + reservation.status);
        io:println("- Total Amount: $" + reservation.totalAmount.toString());
        io:println("- Items: " + reservation.items.length().toString() + " cars");
        
        foreach var item in reservation.items {
            io:println("  * " + item.plate + " (" + item.start_date + " to " + item.end_date + ")");
        }
    }
    
    io:println("✓ Successfully placed reservation!\n");
}

// Demo function 7: Admin updates car details
function updateCarDemo() returns error? {
    io:println("7. Admin updating car details...");
    
    Car carUpdate = {
        plate: "N 346273 W", // Keep existing
        make: "",  // Keep existing
        model: "", // Keep existing 
        year: 0,   // Keep existing
        dailyPrice: 80.00, // Update price
        mileage: 0, // Keep existing
        status: AVAILABLE // Keep available
    };
    
    UpdateCarRequest updateRequest = {
        plate: "N 346273 W",
        car_update: carUpdate
    };
    
    UpdateCarResponse updateResponse = check carRentalClient->UpdateCar(updateRequest);
    io:println("Update result: " + updateResponse.message);
    if updateResponse.updated_car.plate != "" {
        Car updatedCar = updateResponse.updated_car;
        io:println("Updated car: " + updatedCar.make + " " + updatedCar.model + 
                  " - New daily rate: $" + updatedCar.dailyPrice.toString());
    }
    
    io:println("✓ Successfully updated car details!\n");
}

// Demo function 8: Admin lists all reservations
function listReservationsDemo() returns error? {
    io:println("8. Admin viewing all reservations...");
    
    ListReservationsRequest listRequest = {};
    ListReservationsResponse listResponse = check carRentalClient->ListReservations(listRequest);
    
    io:println("Total reservations: " + listResponse.reservations.length().toString());
    io:println("Reservation List:");
    io:println("=================");
    
    foreach var reservation in listResponse.reservations {
        io:println("ID: " + reservation.reservationId + 
                  " | Customer: " + reservation.customerId + 
                  " | Amount: $" + reservation.totalAmount.toString() + 
                  " | Status: " + reservation.status);
    }
    
    io:println("✓ Successfully retrieved all reservations!\n");
}

// Demo function 9: Admin removes a car
function removeCarDemo() returns error? {
    io:println("9. Admin removing a car from inventory...");
    
    RemoveCarRequest removeRequest = {plate: "NAM-002"};
    RemoveCarResponse removeResponse = check carRentalClient->RemoveCar(removeRequest);
    
    io:println("Remove result: " + removeResponse.message);
    io:println("Remaining cars in inventory: " + removeResponse.remaining_cars.length().toString());
    
    foreach var car in removeResponse.remaining_cars {
        io:println("- " + car.plate + ": " + car.make + " " + car.model);
    }
    
    io:println("✓ Successfully removed car from inventory!\n");
}
