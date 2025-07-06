-- User table indexes
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_role ON users(role);
CREATE INDEX idx_user_created_at ON users(created_at);

-- Booking table indexes
CREATE INDEX idx_booking_property ON bookings(property_id);
CREATE INDEX idx_booking_user ON bookings(user_id);
CREATE INDEX idx_booking_status ON bookings(status);
CREATE INDEX idx_booking_dates ON bookings(start_date, end_date);
CREATE INDEX idx_booking_created_at ON bookings(created_at);

-- Property table indexes
CREATE INDEX idx_property_host ON properties(host_id);
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_property_price ON properties(pricepernight);
CREATE INDEX idx_property_created_at ON properties(created_at);

-- Composite index for common property search patterns
CREATE INDEX idx_property_search ON properties(location, pricepernight);


-- Example query to analyze
-- EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.location, p.pricepernight
FROM properties p
JOIN bookings b ON p.property_id = b.property_id
WHERE p.location = 'Paris'
AND p.pricepernight BETWEEN 100 AND 200
AND b.start_date > '2023-01-01'
ORDER BY p.pricepernight;

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
