# Airbnb Database ER Diagram

## Objective

Create an Entity-Relationship Diagram (ERD) based on the Airbnb-style database specification.

## Entities

- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

## Relationships

- A User can own many Properties.
- A User can make many Bookings.
- A User can leave many Reviews.
- A User can send and receive Messages.
- A Property can have many Bookings and Reviews.
- A Booking is associated with exactly one Payment.

## Diagram

The ER diagram is saved in this directory as:

📄 **airbnb-database-diagram.png**
