# 📊 Airbnb Database Schema

This file explains the database structure defined in `schema.sql`. It includes a description of each table, its fields, data types, constraints, and relationships.

---

## 📌 Table: `users`

Stores information about all users (guests, hosts, admins).

| Column         | Type                     | Description                         |
|----------------|--------------------------|-------------------------------------|
| user_id        | UUID (PK)                | Unique ID for each user             |
| first_name     | VARCHAR(100)             | User's first name                   |
| last_name      | VARCHAR(100)             | User's last name                    |
| email          | VARCHAR(255), UNIQUE     | Must be unique                      |
| password_hash  | VARCHAR(255)             | Secure password hash                |
| phone_number   | VARCHAR(20), NULLABLE    | Optional contact number             |
| role           | ENUM (guest, host, admin)| User role in the platform           |
| created_at     | TIMESTAMP                | Auto-generated at registration      |

**Indexes**:
- `idx_user_email`: For quick email lookup.

---

## 📌 Table: `properties`

Represents listings that hosts make available for booking.

| Column         | Type               | Description                            |
|----------------|--------------------|----------------------------------------|
| property_id    | UUID (PK)          | Unique property ID                     |
| host_id        | UUID (FK → users)  | Linked to the hosting user             |
| name           | VARCHAR(255)       | Property name                          |
| description    | TEXT               | Description of the property            |
| location       | VARCHAR(255)       | General location string                |
| pricepernight  | DECIMAL(10,2)      | Price per night                        |
| created_at     | TIMESTAMP          | Date listed                            |
| updated_at     | TIMESTAMP          | Last update timestamp                  |

**Indexes**:
- `idx_property_host`: Speeds up filtering by host.

---

## 📌 Table: `bookings`

Captures reservation data for properties.

| Column         | Type                         | Description                          |
|----------------|------------------------------|--------------------------------------|
| booking_id     | UUID (PK)                    | Unique ID per booking                |
| property_id    | UUID (FK → properties)       | Booked property                      |
| user_id        | UUID (FK → users)            | Guest who booked                     |
| start_date     | DATE                         | Check-in date                        |
| end_date       | DATE                         | Check-out date                       |
| total_price    | DECIMAL(10,2)                | Total cost for the stay              |
| status         | ENUM (pending, confirmed, canceled) | Booking status               |
| created_at     | TIMESTAMP                    | When the booking was made            |

**Indexes**:
- `idx_booking_property`
- `idx_booking_user`

---

## 📌 Table: `payments`

Handles payments for each booking.

| Column         | Type                            | Description                          |
|----------------|----------------------------------|--------------------------------------|
| payment_id     | UUID (PK)                        | Unique payment ID                    |
| booking_id     | UUID (FK → bookings)             | Linked to a specific booking         |
| amount         | DECIMAL(10,2)                    | Payment amount                       |
| payment_date   | TIMESTAMP                        | When the payment was made            |
| payment_method | ENUM (credit_card, paypal, stripe) | Method used                      |

**Index**:
- `idx_payment_booking`

---

## 📌 Table: `reviews`

Stores user-generated reviews for properties.

| Column         | Type                          | Description                           |
|----------------|-------------------------------|---------------------------------------|
| review_id      | UUID (PK)                     | Unique ID for the review              |
| property_id    | UUID (FK → properties)        | Reviewed property                     |
| user_id        | UUID (FK → users)             | Reviewer                              |
| rating         | INT (CHECK 1–5)               | Star rating                           |
| comment        | TEXT                          | Review text                           |
| created_at     | TIMESTAMP                     | Review date                           |

**Constraints**:
- `UNIQUE(property_id, user_id)`: A user can review a property only once.

**Indexes**:
- `idx_review_property`
- `idx_review_user`

---

## 📌 Table: `messages`

Allows users to send private messages to each other.

| Column         | Type                    | Description                            |
|----------------|-------------------------|----------------------------------------|
| message_id     | UUID (PK)               | Unique ID per message                  |
| sender_id      | UUID (FK → users)       | User who sent the message              |
| recipient_id   | UUID (FK → users)       | Recipient of the message               |
| message_body   | TEXT                    | Message content                        |
| sent_at        | TIMESTAMP               | Time sent                              |

**Indexes**:
- `idx_message_sender`
- `idx_message_recipient`

---

## ✅ Summary

- Foreign key constraints enforce data integrity.
- ENUMs constrain values for roles, booking status, and payment method.
- All tables use UUIDs for scalability and security.
- Indexes optimize performance for common queries.
