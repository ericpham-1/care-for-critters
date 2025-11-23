USE careforcritters;

INSERT INTO Address (AddressID, BuildingNo, Street, City, Province, PostalCode)
VALUES
    (DEFAULT, '143', 'Maple Street', 'Calgary', 'Alberta', 'A1B 3C4'),
    (DEFAULT, '246', 'Oak Row', 'Calgary', 'Alberta', 'X1Y 3Z4');

INSERT INTO Shelter (ShelterName, PhoneNumber, ShelterAddress)
VALUES
    ('Maple Street Branch', '(403) 111 2222', '1'),
    ('Oak Row Branch', '(403) 456 4567', '2');

INSERT INTO Animal (PetID, Name, Description, Age, Diet, ShelterLocation)
VALUES 
    (1, 'Max', 'Friendly golden retriever', 4, 'Dog food', 'Oak Row Branch'),
    (2,'Whiskers', 'Playful tabby cat', 2, 'Cat food', 'Maple Street Branch'),
    (3,'Nemo', 'Clownfish', 1, 'Fish flakes', 'Maple Street Branch'),
    (4,'Spike', 'Bearded dragon', 3, 'Insects and veggies', 'Maple Street Branch'),
    (5,'James', 'Sugar Glider', 1, 'Fruits and veggies', 'Maple Street Branch'),
    (6,'Sir Ruffles','Ragdoll Cat', 3, 'Cat food', 'Oak Row Branch');

INSERT INTO Mammal (PetID, Species, HealthRecords, Weight)
VALUES 
    (1, 'Golden Retriever', 'All vaccinations up to date', 28.0),
    (2, 'Tabby Cat', 'Healthy, neutered', 4.2),
    (5, 'Sugar Glider', 'Healthy', 1.0),
    (6, 'Ragdoll Cat', 'Vaccinations up to date', 20.0);

INSERT INTO Fish (PetID, Species, WaterType)
VALUES 
    (3, 'Clownfish', 'Saltwater');

INSERT INTO Exotic (PetID, Species, HabitatRequirements, Weight)
VALUES 
    (4, 'Bearded Dragon', 'Terrarium with heat lamp', 0.4);

INSERT INTO SPONSOR(SponsorID, Fname, Lname, Email, PhoneNumber)
VALUES
    (1, 'Jimothy', 'Socks', 'e@ucalgary.ca', "1234567891");

INSERT INTO Donation(DonationID, SponsorID, ShelterName, AmountDonated)
VALUES  
    (1, 1, 'Maple Street Branch', 25.00);

-- Create a supervisor account for testing login
INSERT INTO Address (AddressID, BuildingNo, Street, City, Province, PostalCode)
VALUES (3, '456', 'Admin Lane', 'Calgary', 'Alberta', 'B2C 4D5');

INSERT INTO Worker (WorkerID, Name, Email, PhoneNumber, AddressID, ShelterName)
VALUES (1, 'Admin User', 'admin@careforcritters.com', '(403) 555-1234', 3, 'Maple Street Branch');

INSERT INTO Supervisor (WorkerID, Salary)
VALUES (1, 50000.00);

INSERT INTO Account (Username, Password, SupervisorID) 
VALUES ('admin', 'password123', 1);

INSERT INTO Fundraiser (EventName, EventLocation, EventDate, Budget, ShelterName, AmountRaised)
VALUES
    ('Grand Opening Event', 'Central Park', '2025-12-1', 2000,  'Oak Row Branch', 5000),
    ('2008 Christmas Party', 'Maple Street Branch', '2008-12-1', 2000,  'Maple Street Branch', 7000),
    ('FruFru\'s Birthday Bash', 'Main Street', '2026-3-21', 1000,  'Maple Street Branch', 10000);
