-- CREATE DATABASE IF NOT EXISTS careforcritters;
USE careforcritters;

-- =====================
-- ADDRESS 
-- =====================
CREATE TABLE Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    BuildingNo VARCHAR(10),
    Street VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(50),
    PostalCode VARCHAR(10)
);

-- =====================
-- SHELTER
-- =====================
CREATE TABLE Shelter (
    ShelterName VARCHAR(100) PRIMARY KEY,
    PhoneNumber VARCHAR(15),
    ShelterAddress INT,
    FOREIGN KEY (ShelterAddress) REFERENCES Address(AddressID)
);

-- =====================
-- ANIMAL (depends on Shelter)
-- =====================
CREATE TABLE Animal (
    PetID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    Age INT,
    Diet VARCHAR(100),
    Photo VARCHAR(2048),
    ShelterLocation VARCHAR(100),
    AdoptionStatus VARCHAR(100),
    FOREIGN KEY (ShelterLocation) REFERENCES Shelter(ShelterName)
);

-- =====================
-- ADOPTER (depends on Address)
-- =====================
CREATE TABLE Adopter (
    AdopterID INT AUTO_INCREMENT PRIMARY KEY,
    DriverLicenseNo VARCHAR(50) UNIQUE,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    AddressID INT,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- =====================
-- ADOPTION (links Adopter and Animal)
-- =====================
CREATE TABLE Adoption (
    AdoptionID INT AUTO_INCREMENT PRIMARY KEY,
    AdopterID INT,
    PetID INT,
    AdoptionDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (AdopterID) REFERENCES Adopter(AdopterID),
    FOREIGN KEY (PetID) REFERENCES Animal(PetID)
);

-- =====================
-- WORKER (depends on Address and Shelter)
-- =====================
CREATE TABLE Worker (
    WorkerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    AddressID INT,
    ShelterName VARCHAR(100),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (ShelterName) REFERENCES Shelter(ShelterName)
);

-- =====================
-- VOLUNTEER (depends on Worker)
-- =====================
CREATE TABLE Volunteer (
    WorkerID INT PRIMARY KEY,
    HoursWorked INT,
    Responsibilities TEXT,
    FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID)
);

-- =====================
-- SUPERVISOR (depends on Worker)
-- =====================
CREATE TABLE Supervisor (
    WorkerID INT PRIMARY KEY,
    Salary DECIMAL(10,2),
    FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID)
);

-- =====================
-- ACCOUNT (depends on Supervisor)
-- =====================
CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(255),
    SupervisorID INT UNIQUE,
    FOREIGN KEY (SupervisorID) REFERENCES Supervisor(WorkerID)
);

-- =====================
-- Animal Subclasses (depend on Animal)
-- =====================
CREATE TABLE Mammal (
    PetID INT PRIMARY KEY,
    Species VARCHAR(50),
    HealthRecords TEXT,
    Weight DECIMAL(5,2),
    FOREIGN KEY (PetID) REFERENCES Animal(PetID)
);

CREATE TABLE Fish (
    PetID INT PRIMARY KEY,
    Species VARCHAR(50),
    WaterType VARCHAR(50),
    FOREIGN KEY (PetID) REFERENCES Animal(PetID)
);

CREATE TABLE Exotic (
    PetID INT PRIMARY KEY,
    Species VARCHAR(50),
    HabitatRequirements TEXT,
    Weight DECIMAL(5,2),
    FOREIGN KEY (PetID) REFERENCES Animal(PetID)
);

-- =====================
-- SPONSOR (no dependencies)
-- =====================
CREATE TABLE Sponsor (
    SponsorID INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(100),
    Lname VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15)
    );

-- =====================
-- RELATIONSHIPS
-- =====================
CREATE TABLE Donation (
    DonationID INT AUTO_INCREMENT PRIMARY KEY,
    SponsorID INT,
    ShelterName VARCHAR(100),
    AmountDonated DECIMAL(10,2),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (ShelterName) REFERENCES Shelter(ShelterName)
);

-- =====================
-- FUNDRAISER
-- =====================
CREATE TABLE FUNDRAISER (
    EventName VARCHAR(100),
    EventLocation VARCHAR(100),
    EventDate DATE,
    BUDGET INT,
    ShelterName VARCHAR(100),
    AmountRaised INT,
    PRIMARY KEY (EventName, EventLocation, EventDate),
    FOREIGN Key (ShelterName) REFERENCES Shelter(ShelterName)
);