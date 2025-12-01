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
    (10, 'Annie', 'Blue angelfish', 1, 'Fish food', 'https://www.swelluk.com/media/catalog/product/b/l/blue_angelfish.png?store=default&image-type=image', 'Oak Row Branch'),
    (11, 'Missy', 'Beautiful Cocker Spaniel', 3, 'Dog food', 'https://thehappypuppysite.com/wp-content/uploads/2019/04/The-English-Cocker-Spaniel-HP-long.jpg', 'Oak Row Branch'),
    (12, 'Mr. Bennet', 'Friendly old goat', 6, 'Wheat and anything, really', 'https://ogden_images.s3.amazonaws.com/www.iamcountryside.com/images/sites/2/2023/03/13120626/OEGS-2-scaled-e1679940131468.jpg', 'Maple Street Branch'),
    (13, 'Pirate Roberts', 'Talktative Parrot', 2, 'Seeds and peanut butter', 'https://www.thesprucepets.com/thmb/pD3IuYFkYzZhTtVaxFPtsgdmUSY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/parrot--sun-conure--perching-on-blurred-garden-background-515531466-5ace5b40ae9ab8003826c3dd.jpg', 'Birch Grove Branch'),
    (14, 'Winter', 'Family friendly husky', 5, 'Dog food', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmf.b37mrtl.ru%2Frbthmedia%2Fimages%2F2023.01%2Foriginal%2F63c54448fa390f007f458924.jpg&f=1&nofb=1&ipt=a687eb86590b7a51e3f9fc2d62d90463d515943f37feaa15bf47a74749c22ca1', 'Oak Row Branch'),
    (15, 'Shimmer', 'Lively Goldfish with golden scales', 1, 'Fish pellets', 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fcdn.sheknows.com%2Farticles%2F2014%2F05%2FMike_C%2FChefMom%2FGoldfish2.jpg&f=1&nofb=1&ipt=f950ff534cdedf6bf14b557718490317e0d1100a342d76848ac68ac4b52cedde', 'Maple Street Branch'),
    (16, 'Maria', 'Pink betafish', 1, 'Fish pellets', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fanimalia-life.club%2Fdata_images%2Ffish%2Ffish2.jpg&f=1&nofb=1&ipt=ed249fca0c727dc1b99f18305cbf94cabbbb9779e460a4a92c27f16b9358e67e', 'Oak Row Branch'),
    (17, 'Hank', 'Friendly little turtle', 7, 'Greens and some bugs', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.thoughtco.com%2Fthmb%2F8_MCVXj2Hi-sSbq_ixH16cqXBG8%3D%2F1920x1279%2Ffilters%3Ano_upscale()%3Amax_bytes(150000)%3Astrip_icc()%2Fturtle-509524_1920-5c429d55c9e77c000127edd2.jpg&f=1&nofb=1&ipt=f5ebd64d619464378af90a47b058990802618e9e896e877cfd0ec2028970728d', 'Maple Street Branch'),
    (18, 'Bubbles', 'Colourful betafish', 1, 'Fish pellets', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.primeapi.com%2Fcmscdn%2Fcdn%2Fcms%2FSNG%2Fmost_expensive_betta_fish_type_cc878f09a9.jpg&f=1&nofb=1&ipt=5445d26fe235cd4b0a507b24905006cfc0a0139012e5a82019615ab156211b95', 'Birch Grove Branch'),
    (19, 'Hero', 'Little goldfish', 1, 'Fish pellets', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ffirstquarterfinance.com%2Fwp-content%2Fuploads%2FWhat-to-Do-With-Unwanted-Pet-Fish-Featured-Image.jpg&f=1&nofb=1&ipt=f00e162add66739dce9c3a90cdb8678fb1660bb896f739d65d4617bb4962c05e', 'Maple Street Branch'),
    (20, 'Ringo', 'Friendly little gecko', 2, 'Bugs and greens', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ffriendlypets.com%2Fwp-content%2Fuploads%2F2020%2F04%2FCanva-Leopard-gecko-scaled.jpg&f=1&nofb=1&ipt=9bfdaad6a2f4bc3d75a69850ddbdb7171af35d63b98cd03eeecf7ee9afe6267a', 'Oak Row Branch'),
    (21, 'Jumper', 'Little tree frog who loves to jump', 3, 'Bugs', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.saymedia-content.com%2F.image%2Ft_share%2FMTczOTYxMDI4MjkwNDIyNjUx%2Fgreen-tree-frogs.jpg&f=1&nofb=1&ipt=d345304820b878d16ccb083ade1ef9e9cb6b411ad76d9f3dcf2bf20d920d2ec2', 'Maple Street Branch');

INSERT INTO Mammal (PetID, Species, HealthRecords, Weight)
VALUES 
    (1, 'Golden Retriever', 'All vaccinations up to date', 28.0),
    (2, 'Tabby Cat', 'Healthy, neutered', 4.2),
    (5, 'Sugar Glider', 'Healthy', 1.0),
    (6, 'Ragdoll Cat', 'Vaccinations up to date', 20.0),
    (11, 'Cocker Spaniel', 'Vaccinations up to date', 15.2),
    (12, 'Goat', 'Healthy', 25),
    (14, 'Husky', 'Vaccination up to date', 15.5);

INSERT INTO Fish (PetID, Species, WaterType)
VALUES 
    (3, 'Clownfish', 'Saltwater'),
    (8, 'Corydoras', 'Freshwater'),
    (10, 'Angelfish', 'Freshwater'),
    (15, 'Goldfish', 'Freshwater'),
    (16, 'Betafish', 'Freshwater'),
    (18, 'Betafish', 'Freshwater'),
    (19, 'Goldfish', 'Freshwater');

INSERT INTO Exotic (PetID, Species, HabitatRequirements, Weight)
VALUES 
    (4, 'Bearded Dragon', 'Terrarium with heat lamp', 0.4),
    (7, 'Turtle', 'Aquarium', 0.5),
    (9, 'Toad', 'Terrarium', 3.14),
    (13, 'Parrot', 'Cage with nest', 0.35),
    (17, 'Turtle', 'Terrarium with heat lamp', 3.2),
    (20, 'Gecko', 'Terrarium with heat lamp', 1.5),
    (21, 'Tree Frog', 'Terrarium with pond and heat lamp', 2.0);

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
    (DEFAULT, 'Wanda Maximoff', 'wmaximoff@email.com', '(403) 444-5555', 13, 'Oak Row Branch'),
    (DEFAULT, 'Tessa Gray', 't.gray@careforcritter.com', '(403) 587-8715', 8, 'Birch Grove Branch');

-- =====================
-- SUPERVISOR
-- =====================
INSERT INTO Supervisor (WorkerID, Salary)
VALUES (1, 50000.00),
        (11, 60000.00);

-- =====================
-- ACCOUNT
-- =====================
INSERT INTO Account (Username, Password, SupervisorID) 
VALUES ('admin', 'password123', 1),
        ('t.gray', 'password456', 11);

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
INSERT INTO Fundraiser (EventName, EventLocation, EventDate, EventTime, Budget, ShelterName, AmountRaised)
VALUES
    ('Grand Opening Event', 'Central Park', '2025-12-01', '14:00:00', 2000, 'Oak Row Branch', 5000),
    ('2008 Christmas Party', 'Maple Street Branch', '2008-12-01', '18:00:00', 2000, 'Maple Street Branch', 7000),
    ('FruFru Birthday Bash', 'Main Street', '2026-03-21', '12:30:00', 1000, 'Maple Street Branch', 10000),
    ('Spring Pet Adoption Fair', 'Prince Island Park', '2026-04-15', '10:30:00', 3000, 'Birch Grove Branch', 8500),
    ('Summer BBQ Fundraiser', 'Oak Row Branch', '2026-06-20', '14:00:00', 1500, 'Oak Row Branch', 4200),
    ('Fall Charity Walk', 'Bow River Pathway', '2026-09-10', '15:30:00', 2500, 'Maple Street Branch', 6800);

    
-- =====================
-- Adopters
-- =====================
INSERT INTO Adopter(AdopterID, DriverLicenseNo, Fname, Lname, Email, PhoneNumber, AddressID)
VALUES
    (DEFAULT, 'D1234567', 'Jimothy', 'Socks', 'jimothy.socks@email.com', '(403) 123-4567', 9), 
    (DEFAULT, 'E9876543', 'Clara', 'Klay', 'Clara.Klay@email.com', '(825) 153-2495', 13), 
    (DEFAULT, 'F4567890', 'Ivan', 'Rawya', 'Ivan.Rawya@email.com', '(403) 835-1535', 10),     
    (DEFAULT, 'G3456789', 'Sarah', 'Johnson', 'sarah.j@email.com', '(403) 234-5678', 8),  
    (DEFAULT, 'H6789012', 'Emily', 'Rodriguez', 'emily.r@email.com', '(403) 456-7890', 7);  

-- =====================
-- Adoption Applications
-- =====================
INSERT INTO Adoption(AdoptionID, AdopterID, PetID, AdoptionDate, Status)
VALUES
    (DEFAULT, 1, 1, '2025-9-23', 'Rejected'),
    (DEFAULT, 1, 3, '2025-10-15', 'Rejected'),
    (DEFAULT, 1, 5, '2025-10-20', 'Pending'),
    (DEFAULT, 2, 4, '2025-11-20', 'Rejected'),
    (DEFAULT, 3, 2, '2025-11-21', 'Rejected'),
    (DEFAULT, 4, 3, '2025-11-22', 'Rejected'),
    (DEFAULT, 5, 4, '2025-11-23', 'Rejected'),
    (DEFAULT, 5, 5, '2025-11-23', 'Pending'),
    (DEFAULT, 4, 6, '2025-11-24', 'Pending'),
    (DEFAULT, 3, 7, '2025-11-24', 'Pending'),
    (DEFAULT, 2, 8, '2025-11-24', 'Pending'),
    (DEFAULT, 3, 9, '2025-11-25', 'Pending');