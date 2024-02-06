--Made By Zackary Paulson

-- Trips 
-- Takes in info about the trip details 
CREATE TABLE Trips (
    TripID INT PRIMARY KEY,
    Date DATE,
    Destination VARCHAR(255),
    StartTime TIME,
    ArrivalTime TIME,
    ReturnDate DATE,
    ReturnStartTime TIME,
    ReturnArrivalTime TIME
);

-- Vehicles
-- Takes in info about the Vehicles
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    StartingMileage INT,
    EndingMileage INT,
    FuelLevel DECIMAL(5,2),
    StartingCondition VARCHAR(255),
    EndingCondition VARCHAR(255),
    ReportedIssues TEXT,
    Destination VARCHAR(255),
    ReasonForTrip TEXT,
    OilChangeNeeded BOOLEAN,
    TripID INT,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID)
);

-- Passengers
-- Takes in info about Passenger
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FullName VARCHAR(255),
    DOB DATE,
    Address VARCHAR(255),
    TripID INT,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID)
);

-- Drivers
-- Takes in infor about drivers
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FullName VARCHAR(255),
    DOB DATE,
    Address VARCHAR(255),
    LicenseNumber VARCHAR(255),
    TripID INT,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID)
);

-- Trigger for Oil Change
-- Set to trigger every 4000 miles a car travels
CREATE TRIGGER OilChangeTrigger
ON Vehicles
AFTER UPDATE OF EndingMileage
ON
BEGIN
    UPDATE Vehicles
    SET OilChangeNeeded = 1
    WHERE (INSERTED.EndingMileage - DELETED.EndingMileage) >= 4000; 
END;
