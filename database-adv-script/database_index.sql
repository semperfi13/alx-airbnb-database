-- Users Table
-- Stores user information.
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    last_login TIMESTAMP
);

-- Properties Table
-- Stores details about properties available for booking.
CREATE TABLE Properties (
    property_id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL, -- Foreign key to Users.user_id
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    property_type VARCHAR(50), -- e.g., 'Apartment', 'House', 'Villa'
    max_guests INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings Table
-- Stores booking details for properties.
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL, -- Foreign key to Users.user_id
    property_id INT NOT NULL, -- Foreign key to Properties.property_id
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending', -- e.g., 'pending', 'confirmed', 'cancelled', 'completed'
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
