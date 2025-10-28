CREATE DATABASE IF NOT EXISTS 471_db;
USE 471_db;

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
    ShelterID INT AUTO_INCREMENT PRIMARY KEY,
    PhoneNumber VARCHAR(15),
    BuildingNo VARCHAR(10),
    Street VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(50),
    PostalCode VARCHAR(10)
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
    Photo VARCHAR(255),
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelter(ShelterID)
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
    ShelterID INT,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (ShelterID) REFERENCES Shelter(ShelterID)
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
    Name VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

-- =====================
-- RELATIONSHIPS
-- =====================
CREATE TABLE SponsorShelter (
    SponsorID INT,
    ShelterID INT,
    AmountDonated DECIMAL(10,2),
    PRIMARY KEY (SponsorID, ShelterID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (ShelterID) REFERENCES Shelter(ShelterID)
);