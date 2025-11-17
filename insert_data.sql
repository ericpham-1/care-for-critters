USE 471_db;

INSERT INTO Shelter (ShelterID, PhoneNumber, BuildingNo, Street, City, Province, PostalCode)
VALUES
    ('1', '1234567890', '143', 'Maple Street', 'Calgary', 'Alberta', 'A1B 3C4');

INSERT INTO Animal (PetID, Name, Description, Age, Diet, ShelterID)
VALUES 
    (2, 'Max', 'Friendly golden retriever', 4, 'Dog food', 1),
    (3,'Whiskers', 'Playful tabby cat', 2, 'Cat food', 1),
    (4,'Nemo', 'Clownfish', 1, 'Fish flakes', 1),
    (5,'Spike', 'Bearded dragon', 3, 'Insects and veggies', 1),
    (6,'James', 'Sugar Glider', 1, 'Fruits and veggies', 1),
    (7,'Sir Ruffles','Ragdoll Cat', 3, 'Cat food', 1);

INSERT INTO Mammal (PetID, Species, HealthRecords, Weight)
VALUES 
    (2, 'Dog', 'All vaccinations up to date', 28.0),
    (3, 'Cat', 'Healthy, neutered', 4.2),
    (6, 'Sugar Glider', 'Healthy', 1.0),
    (7, 'Ragdoll Cat', 'Vaccinations up to date', 20.0);

INSERT INTO Fish (PetID, Species, WaterType)
VALUES 
    (4, 'Clownfish', 'Saltwater');

INSERT INTO Exotic (PetID, Species, HabitatRequirements, Weight)
VALUES 
    (5, 'Bearded Dragon', 'Terrarium with heat lamp', 0.4);

INSERT INTO Fundraiser (EventName, EventLocation, EventDate, Budget, ShelterLocation, AmountRaised)
VALUES
    ('Grand Opening Event', 'Central Park', '2025-12-1', 2000, 1, 5000);
INSERT INTO Fundraiser (EventName, EventLocation, EventDate, Budget, ShelterLocation, AmountRaised)
VALUES
    ('FruFru\'s Birthday Bash', 'Main Street', '2026-3-21', 1000, 1, 10000);