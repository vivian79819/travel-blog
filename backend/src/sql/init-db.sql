
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Articles;


CREATE TABLE Users (
    id INTEGER NOT NULL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    firstName TEXT,
    lastName TEXT,
    password TEXT NOT NULL,
    blurb TEXT,
    selectedAvatar TEXT,
    email TEXT NOT NULL UNIQUE,
    dob DATE NOT NULL
);


CREATE TABLE Articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT NOT NULL,
    userId INTEGER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Users (username, firstName, lastName, password, blurb, selectedAvatar, email, dob)
VALUES
    ('john_doe', 'John', 'Doe', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'I love coding', 'avatars/avatar1.png', 'john.doe@example.com', '1990-01-15'),
    ('jane_smith', 'Jane', 'Smith', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Coffee enthusiast', 'avatars/avatar2.png', 'jane.smith@example.com', '1992-06-20'),
    ('michael_brown', 'Michael', 'Brown', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Tech geek', 'avatars/avatar3.png', 'michael.brown@example.com', '1988-11-30'),
    ('lisa_wong', 'Lisa', 'Wong', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Art lover', 'avatars/avatar4.png', 'lisa.wong@example.com', '1995-07-14'),
    ('david_jones', 'David', 'Jones', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Fitness addict', 'avatars/avatar5.png', 'david.jones@example.com', '1987-04-22');


INSERT INTO Articles (title, description, content, image, userId, date) VALUES

(
    '10 Days in Bali: A Journey of Discovery',
    'Exploring the hidden gems of Indonesia''s paradise island',
    'From pristine beaches to lush rice terraces, Bali offers a diverse landscape that captivates every traveler. Our 10-day adventure took us through bustling markets, serene temples, and breathtaking sunsets.',
    '6.jpg',
    1,
    '2024-10-01'
),
(
    'The Ultimate Guide to Backpacking Europe',
    'Tips and tricks for budget-friendly travel across the continent',
    'Embarking on a backpacking trip through Europe? Our comprehensive guide covers everything from planning your route to finding the best hostels and hidden local spots in each city.',
    '12.jpg',
    2,
    '2024-09-15'
),
(
    'Sustainable Travel: Eco-Friendly Adventures in Costa Rica',
    'Discover how to explore while minimizing your environmental impact',
    'Costa Rica is a leader in eco-tourism, and our recent trip showcased the country''s commitment to sustainability. Learn about wildlife conservation, eco-lodges, and responsible travel practices.',
    '20.jpg',
    3,
    '2024-01-15'
),
(
    'Culinary Journey Through Southeast Asia',
    'A food lover''s guide to the flavors of Thailand, Vietnam, and Malaysia',
    'Embark on a mouthwatering adventure through the street markets and local eateries of Southeast Asia. From pad thai in Bangkok to pho in Hanoi, discover the region''s most iconic dishes.',
    '6.jpg',
    4,
    '2024-08-01'
),
(
    'Exploring the Ancient Ruins of Machu Picchu',
    'A trek through history in Peru',
    'Machu Picchu is not just a destination but a journey through time. This article chronicles our hike along the Inca Trail and the breathtaking views awaiting us at the top.',
    '12.jpg',
    1,
    '2024-07-20'
),
(
    'A Road Trip Through the Canadian Rockies',
    'Nature’s grandeur in Western Canada',
    'Join us on an unforgettable road trip through the Canadian Rockies, where stunning landscapes, crystal-clear lakes, and diverse wildlife await around every corner.',
    '20.jpg',
    2,
    '2024-06-10'
),
(
    'Island Hopping in the Greek Cyclades',
    'A sun-soaked journey through Greece',
    'Experience the beauty of the Greek islands with our guide to island hopping in the Cyclades. Discover pristine beaches, charming villages, and rich history.',
    '6.jpg',
    3,
    '2024-05-05'
),
(
    'Wildlife Safari in Kenya',
    'An adventure into the heart of Africa',
    'Join us as we explore the breathtaking landscapes of Kenya and witness the majestic wildlife that roams freely in national parks and reserves.',
    '12.jpg',
    4,
    '2024-04-12'
),
(
    'Discovering Japan: A Cultural Odyssey',
    'From bustling Tokyo to serene Kyoto',
    'Travel through Japan and immerse yourself in its rich culture, from the vibrant city life in Tokyo to the peaceful temples of Kyoto.',
    '20.jpg',
    1,
    '2024-03-01'
),
(
    'The Wonders of New Zealand: Nature at Its Best',
    'Adventure in the Land of the Long White Cloud',
    'Explore the stunning landscapes of New Zealand, from the fjords of Milford Sound to the geothermal wonders of Rotorua, in this comprehensive travel guide.',
    '6.jpg',
    2,
    '2024-02-10'
);