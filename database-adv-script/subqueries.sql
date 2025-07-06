SELECT p.property_id,p.name,p.location,p.pricepernight,avg_rating.average_rating
FROM properties p
JOIN (
    SELECT property_id,AVG(rating) AS average_rating
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
) AS avg_rating ON p.property_id = avg_rating.property_id
ORDER BY avg_rating.average_rating DESC;


SELECT u.user_id,u.first_name,u.last_name,u.email,
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.user_id) AS booking_count
FROM users u
WHERE 
    (SELECT COUNT(*) 
     FROM bookings b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY booking_count DESC;