USE careforcritters;

-- =====================
-- ADDRESSES
-- =====================
INSERT INTO Address (AddressID, BuildingNo, Street, City, Province, PostalCode)
VALUES
    (DEFAULT, '143', 'Maple Street', 'Calgary', 'Alberta', 'A1B 3C4'),
    (DEFAULT, '246', 'Oak Row', 'Calgary', 'Alberta', 'X1Y 3Z4'),
    (DEFAULT, '383', 'Birch Grove Avenue', 'Calgary', 'Alberta', 'T3A 6K1'),
    (DEFAULT, '1', 'Wayne Manor Drive', 'Gotham', 'New York', 'BAT M2N'),
    (DEFAULT, '456', 'Admin Lane', 'Calgary', 'Alberta', 'B2C 4D5'),
    (DEFAULT, '789', 'Paradise Island', 'Themyscira', 'Greece', 'W0N D3R'),
    (DEFAULT, '321', '17th Avenue SW', 'Calgary', 'Alberta', 'T2S 0A1'),
    (DEFAULT, '654', 'Kensington Road NW', 'Calgary', 'Alberta', 'T2N 3P7'),
    (DEFAULT, '987', 'Memorial Drive NE', 'Calgary', 'Alberta', 'T2E 2K8'),
    (DEFAULT, '111', 'Crowchild Trail NW', 'Calgary', 'Alberta', 'T3B 4W4'),
    (DEFAULT, '222', 'Macleod Trail SE', 'Calgary', 'Alberta', 'T2G 2M7'),
    (DEFAULT, '333', 'Centre Street N', 'Calgary', 'Alberta', 'T2E 2P6'),
    (DEFAULT, '444', 'Bow Trail SW', 'Calgary', 'Alberta', 'T3C 2G8');

-- =====================
-- SHELTERS
-- =====================
INSERT INTO Shelter (ShelterName, PhoneNumber, ShelterAddress)
VALUES
    ('Maple Street Branch', '(403) 111 2222', '1'),
    ('Oak Row Branch', '(403) 456 4567', '2'),
    ('Birch Grove Branch', '(403) 222 3333', '3');

-- =====================
-- ANIMALS
-- =====================
INSERT INTO Animal (PetID, Name, Description, Age, Diet, Photo, ShelterLocation)
VALUES 
    (1, 'Max', 'Friendly golden retriever', 4, 'Dog food', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgP08_Brwjqpw91miICGPnDK6nFeSyXkEOhQ&s', 'Oak Row Branch'),
    (2, 'Whiskers', 'Playful tabby cat', 2, 'Cat food', 'https://i1.pickpik.com/photos/869/637/291/kitten-newborn-cat-foster-7708c56ddf92a7557a3aaf1a8b538ebe.jpg', 'Maple Street Branch'),
    (3, 'Nemo', 'Clownfish', 1, 'Fish flakes', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxczooPThsOYUIPVcGV2wy69cTWn2EvbCt2g&s', 'Maple Street Branch'),
    (4, 'Spike', 'Bearded dragon', 3, 'Insects and veggies', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0uSQ5K-_jrerFZr1HTT-Qb0VIKpPcaJFzag&s', 'Maple Street Branch'),
    (5, 'James', 'Sugar Glider', 1, 'Fruits and veggies', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJPuayda2pLxrpOh1yKnZ3JJCsIzK1_XGHLg&s', 'Maple Street Branch'),
    (6, 'Sir Ruffles', 'Ragdoll Cat', 3, 'Cat food', 'https://fb-strapi.s3.us-east-1.amazonaws.com/Fit_Bark_rag_doll_cat_059151f4ec.jpg', 'Oak Row Branch'),
    (7, 'Theo', 'Turtle', 1, 'Veggies', 'https://www.weknowpets.com.au/cdn/shop/articles/Untitled_design_48.jpg?v=1682744717', 'Birch Grove Branch'),
    (8, 'Simon', 'Colourful corydoras', 1, 'Fish food', 'https://www.petland.ca/cdn/shop/articles/Bronze-Corydoras.jpg?v=1695136379', 'Birch Grove Branch'),
    (9, 'Frank', '\"Frank the Tank\" toad', 4, 'Fruits and flies', 'https://live.staticflickr.com/65535/53850206471_18d921418e_b.jpg', 'Oak Row Branch'),
    (10, 'Annie', 'Blue angelfish', 1, 'Fish food', 'https://www.swelluk.com/media/catalog/product/b/l/blue_angelfish.png?store=default&image-type=image', 'Oak Row Branch');

INSERT INTO Mammal (PetID, Species, HealthRecords, Weight)
VALUES 
    (1, 'Golden Retriever', 'All vaccinations up to date', 28.0),
    (2, 'Tabby Cat', 'Healthy, neutered', 4.2),
    (5, 'Sugar Glider', 'Healthy', 1.0),
    (6, 'Ragdoll Cat', 'Vaccinations up to date', 20.0);

INSERT INTO Fish (PetID, Species, WaterType)
VALUES 
    (3, 'Clownfish', 'Saltwater'),
    (8, 'Corydoras', 'Freshwater'),
    (10, 'Angelfish', 'Freshwater');

INSERT INTO Exotic (PetID, Species, HabitatRequirements, Weight)
VALUES 
    (4, 'Bearded Dragon', 'Terrarium with heat lamp', 0.4),
    (7, 'Turtle', 'Aquarium', 0.5),
    (9, 'Toad', 'Terrarium', 3.14);

-- =====================
-- SPONSORS (More test data)
-- =====================
INSERT INTO SPONSOR(SponsorID, Fname, Lname, Email, PhoneNumber)
VALUES
    (DEFAULT, 'Jimothy', 'Socks', 'jimothy.socks@email.com', '(403) 123-4567'),
    (DEFAULT, 'Sarah', 'Johnson', 'sarah.j@email.com', '(403) 234-5678'),
    (DEFAULT, 'Michael', 'Chen', 'mchen@email.com', '(403) 345-6789'),
    (DEFAULT, 'Emily', 'Rodriguez', 'emily.r@email.com', '(403) 456-7890'),
    (DEFAULT, 'David', 'Kumar', 'dkumar@email.com', '(403) 567-8901'),
    (DEFAULT, 'Jessica', 'Thompson', 'jthompson@email.com', '(403) 678-9012'),
    (DEFAULT, 'Robert', 'Lee', 'rlee@email.com', '(403) 789-0123'),
    (DEFAULT, 'Amanda', 'Brown', 'abrown@email.com', '(403) 890-1234'),
    (DEFAULT, 'Christopher', 'Wilson', 'cwilson@email.com', '(403) 901-2345'),
    (DEFAULT, 'Jennifer', 'Martinez', 'jmartinez@email.com', '(403) 012-3456');

-- =====================
-- DONATIONS (Multiple donations from various donors to different shelters)
-- =====================
INSERT INTO Donation(DonationID, SponsorID, ShelterName, AmountDonated)
VALUES  
    -- Jimothy Socks - regular donor to Maple Street
    (DEFAULT, 1, 'Maple Street Branch', 25.00),
    (DEFAULT, 1, 'Maple Street Branch', 50.00),
    (DEFAULT, 1, 'Oak Row Branch', 30.00),
    
    -- Sarah Johnson - big donor across all branches
    (DEFAULT, 2, 'Maple Street Branch', 500.00),
    (DEFAULT, 2, 'Oak Row Branch', 750.00),
    (DEFAULT, 2, 'Birch Grove Branch', 600.00),
    (DEFAULT, 2, 'Maple Street Branch', 400.00),
    
    -- Michael Chen - moderate donor
    (DEFAULT, 3, 'Oak Row Branch', 100.00),
    (DEFAULT, 3, 'Oak Row Branch', 150.00),
    
    -- Emily Rodriguez - small regular donations
    (DEFAULT, 4, 'Birch Grove Branch', 25.00),
    (DEFAULT, 4, 'Birch Grove Branch', 25.00),
    (DEFAULT, 4, 'Birch Grove Branch', 25.00),
    (DEFAULT, 4, 'Birch Grove Branch', 25.00),
    
    -- David Kumar - one-time large donation
    (DEFAULT, 5, 'Maple Street Branch', 1000.00),
    
    -- Jessica Thompson
    (DEFAULT, 6, 'Oak Row Branch', 75.00),
    (DEFAULT, 6, 'Maple Street Branch', 50.00),
    
    -- Robert Lee
    (DEFAULT, 7, 'Birch Grove Branch', 200.00),
    (DEFAULT, 7, 'Birch Grove Branch', 150.00),
    
    -- Amanda Brown
    (DEFAULT, 8, 'Maple Street Branch', 35.00),
    (DEFAULT, 8, 'Oak Row Branch', 45.00),
    (DEFAULT, 8, 'Birch Grove Branch', 40.00),
    
    -- Christopher Wilson
    (DEFAULT, 9, 'Oak Row Branch', 300.00),
    
    -- Jennifer Martinez
    (DEFAULT, 10, 'Maple Street Branch', 125.00),
    (DEFAULT, 10, 'Maple Street Branch', 175.00);

-- =====================
-- WORKERS & VOLUNTEERS (More test data)
-- =====================
INSERT INTO Worker (WorkerID, Name, Email, PhoneNumber, AddressID, ShelterName)
VALUES 
    (DEFAULT, 'Admin User', 'admin@careforcritters.com', '(403) 555-1234', 5, 'Maple Street Branch'),
    (DEFAULT, 'Bruce Wayne', 'bruce.wayne@gotham.com', '(403) 123-4567', 4, 'Birch Grove Branch'),
    (DEFAULT, 'Diana Prince', 'diana.prince@jmail.com', '(403) 246-8101', 6, 'Maple Street Branch'),
    (DEFAULT, 'Peter Parker', 'pparker@email.com', '(403) 111-2222', 7, 'Oak Row Branch'),
    (DEFAULT, 'Mary Watson', 'mwatson@email.com', '(403) 333-4444', 8, 'Maple Street Branch'),
    (DEFAULT, 'Tony Stark', 'tstark@email.com', '(403) 555-6666', 9, 'Birch Grove Branch'),
    (DEFAULT, 'Natasha Romanoff', 'nromanoff@email.com', '(403) 777-8888', 10, 'Oak Row Branch'),
    (DEFAULT, 'Steve Rogers', 'srogers@email.com', '(403) 999-0000', 11, 'Maple Street Branch'),
    (DEFAULT, 'Carol Danvers', 'cdanvers@email.com', '(403) 222-3333', 12, 'Birch Grove Branch'),
    (DEFAULT, 'Wanda Maximoff', 'wmaximoff@email.com', '(403) 444-5555', 13, 'Oak Row Branch');

-- =====================
-- SUPERVISOR
-- =====================
INSERT INTO Supervisor (WorkerID, Salary)
VALUES (1, 50000.00);

-- =====================
-- ACCOUNT
-- =====================
INSERT INTO Account (Username, Password, SupervisorID) 
VALUES ('admin', 'password123', 1);

-- =====================
-- VOLUNTEERS (Various hours and responsibilities)
-- =====================
INSERT INTO Volunteer (WorkerID, HoursWorked, Responsibilities)
VALUES 
    (2, 5, 'Cleans the bat cages'),
    (3, 12, 'Cleaning the cages - feeding the cats'),
    (4, 8, 'Dog walking and feeding'),
    (5, 20, 'Cat socialization and playtime'),
    (6, 3, 'General cleaning and maintenance'),
    (7, 15, 'Animal training and behavior support'),
    (8, 25, 'Volunteer coordinator - organizes shifts'),
    (9, 10, 'Photography for adoption listings'),
    (10, 18, 'Event planning and fundraising support');

-- =====================
-- FUNDRAISERS
-- =====================
INSERT INTO Fundraiser (EventName, EventLocation, EventDate, Budget, ShelterName, AmountRaised)
VALUES
    ('Grand Opening Event', 'Central Park', '2025-12-01', 2000, 'Oak Row Branch', 5000),
    ('2008 Christmas Party', 'Maple Street Branch', '2008-12-01', 2000, 'Maple Street Branch', 7000),
    ('FruFru Birthday Bash', 'Main Street', '2026-03-21', 1000, 'Maple Street Branch', 10000),
    ('Spring Pet Adoption Fair', 'Prince Island Park', '2026-04-15', 3000, 'Birch Grove Branch', 8500),
    ('Summer BBQ Fundraiser', 'Oak Row Branch', '2026-06-20', 1500, 'Oak Row Branch', 4200),
    ('Fall Charity Walk', 'Bow River Pathway', '2026-09-10', 2500, 'Maple Street Branch', 6800);

-- =====================
-- Adopters
-- =====================
INSERT INTO Adopter(AdopterID, DriverLicenseNo, Fname, Lname, Email, PhoneNumber, AddressID)
VALUES
    (DEFAULT, 'D1234567', 'Jimothy', 'Socks', 'jimothy.socks@email.com', '(403) 123-4567', 9), 
    (DEFAULT, 'E9876543', 'Clara', 'Klay', 'Clara.Klay@email.com', '(825) 153-2495', 13), 
    (DEFAULT, 'F4567890', 'Ivan', 'Rawya', 'Ivan.Rawya@email.com', '(403) 835-1535', 11);     

-- =====================
-- Adoption Applications
-- =====================
INSERT INTO Adoption(AdoptionID, AdopterID, PetID, AdoptionDate, Status)
VALUES
    (DEFAULT, 1, 1, '2025-9-23', 'Rejected'),
    (DEFAULT, 1, 3, '2025-10-15', 'Accepted'),
    (DEFAULT, 1, 5, '2025-11-20', 'Pending');


