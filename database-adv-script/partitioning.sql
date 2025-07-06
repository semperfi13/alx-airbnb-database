-- partitioning.sql

-- Step 1: Create partitioned table structure
CREATE TABLE bookings_partitioned (
    booking_id UUID,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 2: Create yearly partitions
CREATE TABLE bookings_y2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_y2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_y2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO (MAXVALUE);

-- Step 3: Migrate data from original table (in batches)
INSERT INTO bookings_partitioned 
SELECT * FROM bookings WHERE start_date < '2023-01-01';

INSERT INTO bookings_partitioned 
SELECT * FROM bookings WHERE start_date >= '2023-01-01' AND start_date < '2024-01-01';

INSERT INTO bookings_partitioned 
SELECT * FROM bookings WHERE start_date >= '2024-01-01';

-- Step 4: Create indexes on partitioned table
CREATE INDEX idx_part_booking_dates ON bookings_partitioned(start_date, end_date);
CREATE INDEX idx_part_booking_user ON bookings_partitioned(user_id);
CREATE INDEX idx_part_booking_property ON bookings_partitioned(property_id);
CREATE INDEX idx_part_booking_status ON bookings_partitioned(status);

-- Step 5: Replace original table
BEGIN;
ALTER TABLE bookings RENAME TO bookings_legacy;
ALTER TABLE bookings_partitioned RENAME TO bookings;
COMMIT;

-- Step 6: Add foreign key constraints
ALTER TABLE bookings ADD CONSTRAINT fk_booking_property 
    FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE bookings ADD CONSTRAINT fk_booking_user 
    FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Step 7: Create function to auto-create yearly partitions
CREATE OR REPLACE FUNCTION create_yearly_partitions()
RETURNS TRIGGER AS $$
BEGIN
    EXECUTE format('
        CREATE TABLE IF NOT EXISTS bookings_y%s PARTITION OF bookings
        FOR VALUES FROM (%L) TO (%L)',
        EXTRACT(YEAR FROM CURRENT_DATE + INTERVAL '1 year'),
        DATE(CURRENT_DATE + INTERVAL '1 year'),
        DATE(CURRENT_DATE + INTERVAL '2 years'));
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Step 8: Schedule partition maintenance
CREATE TRIGGER trg_partition_maintenance
AFTER INSERT ON bookings
FOR EACH STATEMENT
EXECUTE FUNCTION create_yearly_partitions();