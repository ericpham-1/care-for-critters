USE careforcritters;

INSERT INTO Address (AddressID, BuildingNo, Street, City, Province, PostalCode)
VALUES
    (DEFAULT, '143', 'Maple Street', 'Calgary', 'Alberta', 'A1B 3C4');

INSERT INTO Shelter (ShelterName, PhoneNumber, ShelterAddress)
VALUES
    ('Maple Street Branch', '(403) 111 2222', '1');

INSERT INTO Animal (PetID, Name, Description, Age, Diet, ShelterLocation)
VALUES 
    (1, 'Max', 'Friendly golden retriever', 4, 'Dog food', 'Maple Street Branch'),
    (2,'Whiskers', 'Playful tabby cat', 2, 'Cat food', 'Maple Street Branch'),
    (3,'Nemo', 'Clownfish', 1, 'Fish flakes', 'Maple Street Branch'),
    (4,'Spike', 'Bearded dragon', 3, 'Insects and veggies', 'Maple Street Branch'),
    (5,'James', 'Sugar Glider', 1, 'Fruits and veggies', 'Maple Street Branch'),
    (6,'Sir Ruffles','Ragdoll Cat', 3, 'Cat food', 'Maple Street Branch');

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


INSERT INTO Fundraiser (EventName, EventLocation, EventDate, Budget, ShelterName, AmountRaised)
VALUES
    ('Grand Opening Event', 'Central Park', '2025-12-1', 2000,  'Maple Street Branch', 5000),
    ('FruFru\'s Birthday Bash', 'Main Street', '2026-3-21', 1000,  'Maple Street Branch', 10000);