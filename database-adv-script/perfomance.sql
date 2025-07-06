-- Initial query retrieving all booking details
SELECT b.booking_id,b.start_date,b.end_date,b.total_price,b.status,u.user_id,
u.first_name,u.last_name,u.email,p.property_id,p.name AS property_name,
p.location,p.pricepernight,py.payment_id,py.amount,py.payment_date,py.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id
ORDER BY b.start_date DESC;