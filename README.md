# Distributed Systems Assignment 1

## Team Members
- Joshua Madzimure (219138451)
- Geraldo Liebenberg (220029326)
- Alina N Daniel (220045216)
- Beauty Masene (220035687)
- Marcheline Matroos (220074291)
- Jeysen Nyandoro (2240058)
- Rowan van wyk (224002244)

## Introduction

This project demonstrates the implementation of distributed systems using Ballerina programming language. We developed two separate systems to showcase different communication paradigms in distributed computing:

1. **Question 1**: A university asset management system using HTTP REST API
2. **Question 2**: A car rental system using gRPC with Protocol Buffers

The project covers essential distributed systems concepts including client-server communication, data serialization, streaming operations, and service-oriented architecture.

## Question 1: Asset Management System

Built a REST API service for managing university assets like computers and lab equipment. The system supports:

- Complete CRUD operations for assets
- Component management (adding/removing parts)
- Maintenance scheduling
- Work order tracking
- Faculty-based filtering

**Files:**
- `Question1/asset_management_service.bal` - HTTP REST service
- `Question1/asset_management_client.bal` - Client application

**To run:**
```bash
cd Question1
bal run asset_management_service.bal  # Start service on port 8081
bal run asset_management_client.bal   # Run client demo
```

## Question 2: Car Rental System

Developed a gRPC service for car rental management with streaming capabilities. Features include:

- Admin operations: fleet management, user creation
- Customer operations: car browsing, cart management, reservations
- Client streaming for bulk operations
- Server streaming for real-time data

**Files:**
- `Question2/wt.proto` - Protocol Buffer definitions
- `Question2/car_rental_service.bal` - gRPC service implementation
- `Question2/car_rental_client.bal` - Client application
- `Question2/stubs/wt_pb.bal` - Generated Ballerina stubs

**To run:**
```bash
cd Question2
bal run car_rental_service.bal  # Start gRPC service on port 9090
bal run car_rental_client.bal   # Run client demo
```

## Project Structure

```
DSA-AS1/
├── README.md
├── LICENSE
├── Question1/
│   ├── asset_management_service.bal
│   └── asset_management_client.bal
└── Question2/
    ├── wt.proto
    ├── car_rental_service.bal
    ├── car_rental_client.bal
    └── stubs/
        └── wt_pb.bal
```

## Technologies Used

- **Ballerina** - Programming language for distributed systems
- **HTTP/REST** - Web service protocol for Question 1
- **gRPC & Protocol Buffers** - RPC framework for Question 2
- **JSON** - Data format for REST APIs

## Conclusion

This assignment provided hands-on experience with distributed systems development using modern technologies. We successfully implemented both REST and gRPC paradigms, demonstrating understanding of:

- Service-oriented architecture principles
- Different communication patterns (synchronous/asynchronous)
- Data serialization and protocol design
- Client-server interaction patterns
- Streaming operations for efficient data transfer

The implementations include comprehensive client applications that demonstrate all functionality, making it easy to test and understand the systems' capabilities. Both services use in-memory storage suitable for development and demonstration purposes.

Through this project, we gained practical experience in building distributed systems that could serve as foundation for real-world applications.