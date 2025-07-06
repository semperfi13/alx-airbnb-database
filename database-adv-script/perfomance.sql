-- Initial comprehensive booking details query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    py.payment_id,
    py.amount,
    py.payment_date,
    py.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
ORDER BY 
    b.start_date DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY;


-- Analyze the initial query
-- EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    py.payment_id,
    py.amount,
    py.payment_date,
    py.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
ORDER BY 
    b.start_date DESC;


-- Optimized booking details query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    p.property_id,
    p.name AS property_name,
    p.location,
    CASE 
        WHEN b.status = 'confirmed' THEN py.amount
        ELSE NULL
    END AS amount_paid,
    py.payment_method
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
INNER JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
WHERE 
    b.start_date >= CURRENT_DATE
ORDER BY 
    b.start_date DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY;