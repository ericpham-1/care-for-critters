USE 471_db;

INSERT INTO Animal (Name, Description, Age, Diet, ShelterID)
VALUES 
    ('Max', 'Friendly golden retriever', 4, 'Dog food', 1),
    ('Whiskers', 'Playful tabby cat', 2, 'Cat food', 1),
    ('Nemo', 'Clownfish', 1, 'Fish flakes', 1),
    ('Spike', 'Bearded dragon', 3, 'Insects and veggies', 1);

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