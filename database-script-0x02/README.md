# Airbnb Database Sample Data

This file explains the sample data SQL script (`seed_data.sql`) used to populate the Airbnb database with realistic example entries.

---

## Purpose

The sample data serves to:

- Demonstrate typical usage of the database schema.
- Enable testing of queries, relationships, and application features.
- Provide realistic users, properties, bookings, payments, reviews, and messages.

---

## Contents of `seed_data.sql`

The script inserts sample records into the following tables:

| Table      | Description                              | Number of Sample Rows |
|------------|------------------------------------------|----------------------|
| `users`    | Guests, hosts, and admins                 | 4                    |
| `properties` | Property listings by hosts               | 2                    |
| `bookings` | Reservations made by guests                | 2                    |
| `payments` | Payment transactions linked to bookings   | 1                    |
| `reviews`  | Guest reviews of properties                | 2                    |
| `messages` | User-to-user messages                       | 2                    |

---
