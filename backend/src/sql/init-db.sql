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