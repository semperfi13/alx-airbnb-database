-- Active: 1741862998814@@127.0.0.1@3306@alx_travel_app
-- ===========================
-- Insert into Users
-- ===========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
  ('00000000-0000-0000-0000-000000000001', 'Alice', 'Smith', 'alice@example.com', 'hashedpass1', '1234567890', 'guest', CURRENT_TIMESTAMP),
  ('00000000-0000-0000-0000-000000000002', 'Bob', 'Johnson', 'bob@example.com', 'hashedpass2', '2345678901', 'host', CURRENT_TIMESTAMP),
  ('00000000-0000-0000-0000-000000000003', 'Carol', 'Taylor', 'carol@example.com', 'hashedpass3', '3456789012', 'guest', CURRENT_TIMESTAMP),
  ('00000000-0000-0000-0000-000000000004', 'Dan', 'Miller', 'dan@example.com', 'hashedpass4', NULL, 'host', CURRENT_TIMESTAMP);

-- ===========================
-- Insert into Properties
-- ===========================
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES 
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Cozy Cottage', 'A beautiful cottage near the lake.', 'Toronto, Canada', 120.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000004', 'City Loft', 'Modern apartment in the city center.', 'New York, USA', 180.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ===========================
-- Insert into Bookings
-- ===========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES 
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '2025-07-10', '2025-07-15', 600.00, 'confirmed', CURRENT_TIMESTAMP),
  ('20000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003', '2025-08-01', '2025-08-05', 720.00, 'pending', CURRENT_TIMESTAMP);

-- ===========================
-- Insert into Payments
-- ===========================
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES 
  ('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 600.00, CURRENT_TIMESTAMP, 'credit_card');

-- ===========================
-- Insert into Reviews
-- ===========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES 
  ('40000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 5, 'Wonderful place, clean and peaceful!', CURRENT_TIMESTAMP),
  ('40000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003', 4, 'Great location but a bit noisy at night.', CURRENT_TIMESTAMP);

-- ===========================
-- Insert into Messages
-- ===========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES 
  ('50000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Hi, is your cottage available next weekend?', CURRENT_TIMESTAMP),
  ('50000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Yes, it is available. Would you like to book it?', CURRENT_TIMESTAMP);
