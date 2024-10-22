-- TODO Replace this SQL initialization script with an init script for your own database schema.

DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INTEGER NOT NULL PRIMARY KEY,
    username TEXT UNIQUE,
    firstName TEXT,
    lastName TEXT,
    password TEXT,  
    blurb TEXT,
    selectedAvatar TEXT,  
    email TEXT NOT NULL,   
    dob DATE NOT NULL      
);


DROP TABLE IF EXISTS Articles;

CREATE TABLE Articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT NOT NULL,
    date TEXT NOT NULL,
    username TEXT NOT NULL,
    userAvatar TEXT NOT NULL
);

INSERT INTO Articles (title, description, content, image, date, username, userAvatar) VALUES
    (
        '10 Days in Bali: A Journey of Discovery',
        'Exploring the hidden gems of Indonesia''s paradise island',
        'From pristine beaches to lush rice terraces, Bali offers a diverse landscape that captivates every traveler. Our 10-day adventure took us through bustling markets, serene temples, and breathtaking sunsets.',
        '6.jpg',
        '2024-10-01',
        'GlobalExplorer',
        'Dragonite.png'
    ),
    (
        'The Ultimate Guide to Backpacking Europe',
        'Tips and tricks for budget-friendly travel across the continent',
        'Embarking on a backpacking trip through Europe? Our comprehensive guide covers everything from planning your route to finding the best hostels and hidden local spots in each city.',
        '12.jpg',
        '2024-09-15',
        'BudgetNomad',
        'Kind Koalas.webp'
    ),
    (
        'Sustainable Travel: Eco-Friendly Adventures in Costa Rica',
        'Discover how to explore while minimizing your environmental impact',
        'Costa Rica is a leader in eco-tourism, and our recent trip showcased the country''s commitment to sustainability. Learn about wildlife conservation, eco-lodges, and responsible travel practices.',
        '20.jpg',
        '2024-01-15',
        'EcoWanderer',
        'Dragonite.png'
    ),
    (
        'Culinary Journey Through Southeast Asia',
        'A food lover''s guide to the flavors of Thailand, Vietnam, and Malaysia',
        'Embark on a mouthwatering adventure through the street markets and local eateries of Southeast Asia. From pad thai in Bangkok to pho in Hanoi, discover the region''s most iconic dishes.',
        '6.jpg',
        '2024-08-01',
        'FoodieExplorer',
        'Kind Koalas.webp'
    );