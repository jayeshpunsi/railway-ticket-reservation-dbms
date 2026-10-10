-- =====================================================
-- RAILWAY TICKET RESERVATION MANAGEMENT SYSTEM
-- DBMS Microproject - VESIT CA (10 Marks)
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS railway_reservation;
USE railway_reservation;

-- =====================================================
-- DDL (Data Definition Language) - CREATE TABLES
-- =====================================================

-- Table 1: Train
CREATE TABLE Train (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(50) NOT NULL,
    source_station VARCHAR(50) NOT NULL,
    destination_station VARCHAR(50) NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    total_seats INT NOT NULL,
    fare_per_seat DECIMAL(8,2) NOT NULL
);

-- Table 2: Passenger
CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    phone_no VARCHAR(15) NOT NULL,
    email VARCHAR(50),
    address VARCHAR(100)
);

-- Table 3: Booking
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    train_id INT NOT NULL,
    booking_date DATE NOT NULL,
    travel_date DATE NOT NULL,
    no_of_tickets INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

-- Table 4: Payment
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_mode VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    transaction_id VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Table 5: Station
CREATE TABLE Station (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    platform_no INT
);

-- Table 6: Ticket
CREATE TABLE Ticket (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_no VARCHAR(10) NOT NULL,
    class_type VARCHAR(20),
    ticket_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- =====================================================
-- DML (Data Manipulation Language) - INSERT DATA
-- =====================================================

-- Insert Train Data
INSERT INTO Train (train_name, source_station, destination_station, departure_time, arrival_time, total_seats, fare_per_seat) VALUES
('Rajdhani Express', 'Mumbai Central', 'Delhi Cantt', '18:30:00', '08:45:00', 200, 1200.00),
('Shatabdi Express', 'Mumbai Central', 'Pune Junction', '08:00:00', '10:30:00', 120, 700.00),
('Duronto Express', 'Delhi Cantt', 'Howrah', '21:00:00', '09:00:00', 180, 1500.00),
('Intercity Express', 'Pune Junction', 'Bangalore', '06:15:00', '15:45:00', 150, 850.00),
('Local Train', 'Mumbai Central', 'Thane', '07:00:00', '07:45:00', 300, 50.00);

-- Insert Passenger Data
INSERT INTO Passenger (passenger_name, age, gender, phone_no, email, address) VALUES
('Amit Sharma', 28, 'Male', '9876543210', 'amit.sharma@gmail.com', '123 Mumbai St, Mumbai'),
('Priya Singh', 24, 'Female', '9123456780', 'priya.singh@gmail.com', '456 Delhi Ave, Delhi'),
('Rahul Verma', 35, 'Male', '9988776655', 'rahul.verma@gmail.com', '789 Pune Rd, Pune'),
('Sneha Patil', 29, 'Female', '8899001122', 'sneha.patil@gmail.com', '321 Bangalore St, Bangalore'),
('Vikram Kumar', 42, 'Male', '7766554433', 'vikram.kumar@gmail.com', '654 Kolkata Lane, Kolkata'),
('Anjali Desai', 26, 'Female', '9555443322', 'anjali.desai@gmail.com', '987 Thane Pk, Thane');

-- Insert Station Data
INSERT INTO Station (station_name, city, platform_no) VALUES
('Mumbai Central', 'Mumbai', 1),
('Pune Junction', 'Pune', 2),
('Delhi Cantt', 'Delhi', 3),
('Howrah', 'Kolkata', 4),
('Bangalore City', 'Bangalore', 5),
('Thane Station', 'Thane', 6);

-- Insert Booking Data
INSERT INTO Booking (passenger_id, train_id, booking_date, travel_date, no_of_tickets, total_amount, booking_status) VALUES
(1, 1, '2026-09-25', '2026-10-15', 2, 2400.00, 'Confirmed'),
(2, 2, '2026-09-26', '2026-10-20', 1, 700.00, 'Confirmed'),
(3, 3, '2026-09-27', '2026-10-25', 3, 4500.00, 'Pending'),
(4, 4, '2026-09-28', '2026-10-10', 2, 1700.00, 'Confirmed'),
(5, 1, '2026-09-29', '2026-10-18', 1, 1200.00, 'Cancelled'),
(6, 5, '2026-09-30', '2026-10-12', 4, 200.00, 'Confirmed'),
(1, 2, '2026-10-01', '2026-10-22', 2, 1400.00, 'Pending'),
(3, 4, '2026-10-02', '2026-10-28', 1, 850.00, 'Confirmed');

-- Insert Payment Data
INSERT INTO Payment (booking_id, payment_date, payment_mode, amount, status, transaction_id) VALUES
(1, '2026-09-25', 'UPI', 2400.00, 'Success', 'TXN001'),
(2, '2026-09-26', 'Credit Card', 700.00, 'Success', 'TXN002'),
(3, '2026-09-27', 'Net Banking', 4500.00, 'Pending', 'TXN003'),
(4, '2026-09-28', 'UPI', 1700.00, 'Success', 'TXN004'),
(5, '2026-09-29', 'Cash', 1200.00, 'Refunded', 'TXN005'),
(6, '2026-09-30', 'Debit Card', 200.00, 'Success', 'TXN006'),
(7, '2026-10-01', 'UPI', 1400.00, 'Pending', 'TXN007'),
(8, '2026-10-02', 'Credit Card', 850.00, 'Success', 'TXN008');

-- Insert Ticket Data
INSERT INTO Ticket (booking_id, seat_no, class_type, ticket_status) VALUES
(1, 'S12', 'Sleeper', 'Confirmed'),
(1, 'S13', 'Sleeper', 'Confirmed'),
(2, 'A5', 'AC 1st', 'Confirmed'),
(3, 'D10', 'Second Class', 'Pending'),
(3, 'D11', 'Second Class', 'Pending'),
(3, 'D12', 'Second Class', 'Pending'),
(4, 'C7', 'AC 2nd', 'Confirmed'),
(4, 'C8', 'AC 2nd', 'Confirmed'),
(6, 'G45', 'General', 'Confirmed'),
(6, 'G46', 'General', 'Confirmed'),
(6, 'G47', 'General', 'Confirmed'),
(6, 'G48', 'General', 'Confirmed');

-- =====================================================
-- DCL (Data Control Language) - USER MANAGEMENT
-- =====================================================

-- Create user for railway staff (Read/Write access)
CREATE USER IF NOT EXISTS 'railway_staff'@'localhost' IDENTIFIED BY 'staff123';
GRANT SELECT, INSERT, UPDATE ON railway_reservation.* TO 'railway_staff'@'localhost';

-- Create user for railway admin (Full access)
CREATE USER IF NOT EXISTS 'railway_admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON railway_reservation.* TO 'railway_admin'@'localhost';

-- Create user for passenger (Read-only access)
CREATE USER IF NOT EXISTS 'passenger_user'@'localhost' IDENTIFIED BY 'pass123';
GRANT SELECT ON railway_reservation.* TO 'passenger_user'@'localhost';

-- Revoke delete permission from staff
REVOKE DELETE ON railway_reservation.* FROM 'railway_staff'@'localhost';

FLUSH PRIVILEGES;

-- =====================================================
-- TCL (Transaction Control Language) - TRANSACTIONS
-- =====================================================

-- Transaction Example 1: Book a ticket and process payment
DELIMITER //
CREATE PROCEDURE BookTicket (
    IN p_passenger_id INT,
    IN p_train_id INT,
    IN p_travel_date DATE,
    IN p_no_tickets INT,
    IN p_payment_mode VARCHAR(20),
    OUT p_booking_id INT
)
BEGIN
    DECLARE p_total_amount DECIMAL(10,2);
    DECLARE p_fare DECIMAL(10,2);
    
    START TRANSACTION;
    
    BEGIN
        -- Get fare
        SELECT fare_per_seat INTO p_fare FROM Train WHERE train_id = p_train_id;
        SET p_total_amount = p_fare * p_no_tickets;
        
        -- Insert booking
        INSERT INTO Booking (passenger_id, train_id, booking_date, travel_date, no_of_tickets, total_amount, booking_status)
        VALUES (p_passenger_id, p_train_id, CURDATE(), p_travel_date, p_no_tickets, p_total_amount, 'Confirmed');
        
        SET p_booking_id = LAST_INSERT_ID();
        
        SAVEPOINT booking_created;
        
        -- Insert payment
        INSERT INTO Payment (booking_id, payment_date, payment_mode, amount, status, transaction_id)
        VALUES (p_booking_id, CURDATE(), p_payment_mode, p_total_amount, 'Success', CONCAT('AUTO_', p_booking_id));
        
        COMMIT;
    END;
END //
DELIMITER ;

-- =====================================================
-- DML QUERIES - SELECT, UPDATE, DELETE
-- =====================================================

-- 1. SELECT all trains
SELECT * FROM Train;

-- 2. SELECT all passengers
SELECT * FROM Passenger;

-- 3. SELECT all bookings
SELECT * FROM Booking;

-- 4. SELECT all payments
SELECT * FROM Payment;

-- 5. SELECT all tickets
SELECT * FROM Ticket;

-- 6. UPDATE booking status
UPDATE Booking
SET booking_status = 'Confirmed'
WHERE booking_id = 3;

-- 7. UPDATE payment status
UPDATE Payment
SET status = 'Success'
WHERE booking_id = 7;

-- 8. DELETE cancelled bookings
DELETE FROM Booking
WHERE booking_status = 'Cancelled';

-- 9. Update passenger phone number
UPDATE Passenger
SET phone_no = '9999999999'
WHERE passenger_id = 1;

-- 10. Add new passenger
INSERT INTO Passenger (passenger_name, age, gender, phone_no, email, address)
VALUES ('Rohit Gupta', 32, 'Male', '8765432109', 'rohit.gupta@gmail.com', '111 Nashik St, Nashik');

-- =====================================================
-- JOIN QUERIES
-- =====================================================

-- 1. Passenger with Booking details
SELECT 
    p.passenger_id,
    p.passenger_name,
    p.phone_no,
    b.booking_id,
    b.booking_date,
    b.total_amount,
    b.booking_status
FROM Passenger p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id;

-- 2. Booking with Train and Passenger details
SELECT 
    b.booking_id,
    p.passenger_name,
    t.train_name,
    t.source_station,
    t.destination_station,
    b.travel_date,
    b.no_of_tickets,
    b.total_amount
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id;

-- 3. Booking with Payment details
SELECT 
    b.booking_id,
    p.passenger_name,
    b.total_amount,
    pay.payment_mode,
    pay.status,
    pay.transaction_id
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Payment pay ON b.booking_id = pay.booking_id;

-- 4. Complete booking details with train, passenger, payment, and ticket
SELECT 
    b.booking_id,
    p.passenger_name,
    p.email,
    t.train_name,
    t.departure_time,
    t.arrival_time,
    b.travel_date,
    tk.seat_no,
    tk.class_type,
    tk.ticket_status,
    b.total_amount,
    pay.payment_mode,
    pay.status as payment_status
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id
INNER JOIN Ticket tk ON b.booking_id = tk.booking_id
INNER JOIN Payment pay ON b.booking_id = pay.booking_id;

-- 5. Ticket with Passenger and Train info
SELECT 
    tk.ticket_id,
    p.passenger_name,
    t.train_name,
    tk.seat_no,
    tk.class_type,
    tk.ticket_status,
    b.travel_date
FROM Ticket tk
INNER JOIN Booking b ON tk.booking_id = b.booking_id
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id;

-- 6. LEFT JOIN - All passengers and their bookings (even if no bookings)
SELECT 
    p.passenger_id,
    p.passenger_name,
    p.phone_no,
    b.booking_id,
    b.booking_status,
    COALESCE(b.total_amount, 0) as amount
FROM Passenger p
LEFT JOIN Booking b ON p.passenger_id = b.passenger_id;

-- 7. Train with all related bookings
SELECT 
    t.train_id,
    t.train_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_amount) as total_revenue
FROM Train t
LEFT JOIN Booking b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- =====================================================
-- AGGREGATE FUNCTIONS
-- =====================================================

-- 1. Total count of bookings
SELECT COUNT(*) as total_bookings FROM Booking;

-- 2. Total revenue from bookings
SELECT SUM(total_amount) as total_revenue FROM Booking;

-- 3. Average booking amount
SELECT AVG(total_amount) as avg_booking_amount FROM Booking;

-- 4. Maximum booking amount
SELECT MAX(total_amount) as max_booking_amount FROM Booking;

-- 5. Minimum booking amount
SELECT MIN(total_amount) as min_booking_amount FROM Booking;

-- 6. Average age of passengers
SELECT AVG(age) as avg_passenger_age FROM Passenger;

-- 7. Count of passengers by gender
SELECT gender, COUNT(*) as count FROM Passenger GROUP BY gender;

-- 8. Bookings count by status
SELECT booking_status, COUNT(*) as count FROM Booking GROUP BY booking_status;

-- 9. Payment count by payment mode
SELECT payment_mode, COUNT(*) as count FROM Payment GROUP BY payment_mode;

-- 10. Payments by status
SELECT status, COUNT(*) as count, SUM(amount) as total FROM Payment GROUP BY status;

-- 11. Bookings per train
SELECT 
    t.train_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_amount) as revenue,
    AVG(b.total_amount) as avg_booking
FROM Train t
LEFT JOIN Booking b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 12. Bookings per passenger
SELECT 
    p.passenger_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_amount) as total_spent
FROM Passenger p
LEFT JOIN Booking b ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.passenger_name;

-- 13. Ticket status summary
SELECT 
    ticket_status,
    COUNT(*) as total_tickets
FROM Ticket
GROUP BY ticket_status;

-- 14. Revenue by payment mode
SELECT 
    payment_mode,
    COUNT(*) as transactions,
    SUM(amount) as total_amount
FROM Payment
GROUP BY payment_mode;

-- 15. Booking status with average amount and count
SELECT 
    booking_status,
    COUNT(*) as bookings,
    SUM(total_amount) as total,
    AVG(total_amount) as average
FROM Booking
GROUP BY booking_status;

-- =====================================================
-- ADVANCED QUERIES WITH SUBQUERIES
-- =====================================================

-- 1. Passengers who booked most expensive tickets
SELECT 
    p.passenger_name,
    b.booking_id,
    b.total_amount
FROM Passenger p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
WHERE b.total_amount = (SELECT MAX(total_amount) FROM Booking);

-- 2. Find trains with more than 1 booking
SELECT t.train_name, COUNT(b.booking_id) as bookings
FROM Train t
INNER JOIN Booking b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(b.booking_id) > 1;

-- 3. Confirmed bookings with successful payments
SELECT 
    p.passenger_name,
    b.booking_id,
    b.total_amount,
    pay.status
FROM Passenger p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
INNER JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.booking_status = 'Confirmed' AND pay.status = 'Success';

-- 4. Pending bookings that need attention
SELECT 
    b.booking_id,
    p.passenger_name,
    t.train_name,
    b.travel_date,
    b.booking_status,
    pay.status as payment_status
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id
INNER JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.booking_status = 'Pending' OR pay.status = 'Pending';

-- 5. High-value bookings (> 2000)
SELECT 
    p.passenger_name,
    t.train_name,
    b.booking_id,
    b.total_amount,
    b.no_of_tickets,
    t.fare_per_seat
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id
WHERE b.total_amount > 2000;

-- =====================================================
-- BUSINESS LOGIC QUERIES
-- =====================================================

-- 1. Passenger journey summary
SELECT 
    p.passenger_name,
    p.email,
    p.phone_no,
    t.train_name,
    t.source_station,
    t.destination_station,
    b.travel_date,
    b.no_of_tickets,
    b.booking_status
FROM Passenger p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
INNER JOIN Train t ON b.train_id = t.train_id
WHERE b.booking_status = 'Confirmed'
ORDER BY b.travel_date;

-- 2. Daily revenue report
SELECT 
    payment_date,
    COUNT(*) as transactions,
    SUM(amount) as daily_revenue,
    status
FROM Payment
GROUP BY payment_date, status
ORDER BY payment_date DESC;

-- 3. Seat occupancy report
SELECT 
    t.train_name,
    COUNT(tk.ticket_id) as booked_seats,
    t.total_seats,
    (COUNT(tk.ticket_id) * 100 / t.total_seats) as occupancy_percentage
FROM Train t
LEFT JOIN Booking b ON t.train_id = b.train_id AND b.booking_status = 'Confirmed'
LEFT JOIN Ticket tk ON b.booking_id = tk.booking_id
GROUP BY t.train_id, t.train_name, t.total_seats;

-- 4. Top booking passengers (by amount spent)
SELECT 
    p.passenger_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_amount) as total_spent,
    AVG(b.total_amount) as avg_spent
FROM Passenger p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.passenger_name
ORDER BY total_spent DESC
LIMIT 5;

-- 5. Refund analysis
SELECT 
    b.booking_id,
    p.passenger_name,
    b.total_amount,
    pay.status,
    DATEDIFF(CURDATE(), b.booking_date) as days_since_booking
FROM Booking b
INNER JOIN Passenger p ON b.passenger_id = p.passenger_id
INNER JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.booking_status = 'Cancelled' OR pay.status = 'Refunded';

-- =====================================================
-- END OF SQL SCRIPT
-- =====================================================
