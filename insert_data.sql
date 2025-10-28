USE 471_db;

INSERT INTO Shelter (ShelterID, PhoneNumber, BuildingNo, Street, City, Province, PostalCode)
VALUES
    ('1', '1234567890', '143', 'Maple Street', 'Calgary', 'Alberta', 'A1B 3C4');


INSERT INTO Animal (PetID, Name, Description, Age, Diet, ShelterID)
VALUES 
    (2, 'Max', 'Friendly golden retriever', 4, 'Dog food', 1),
    (3,'Whiskers', 'Playful tabby cat', 2, 'Cat food', 1),
    (4,'Nemo', 'Clownfish', 1, 'Fish flakes', 1),
    (5,'Spike', 'Bearded dragon', 3, 'Insects and veggies', 1);

INSERT INTO Mammal (PetID, Species, HealthRecords, Weight)
VALUES 
    (2, 'Dog', 'All vaccinations up to date', 28.0),
    (3, 'Cat', 'Healthy, neutered', 4.2);

INSERT INTO Fish (PetID, Species, WaterType)
VALUES 
    (4, 'Clownfish', 'Saltwater');

INSERT INTO Exotic (PetID, Species, HabitatRequirements, Weight)
VALUES 
    (5, 'Bearded Dragon', 'Terrarium with heat lamp', 0.4);