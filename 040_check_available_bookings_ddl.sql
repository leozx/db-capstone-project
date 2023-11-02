USE LittleLemonDB;

-- Create SQL queries to check available bookings based on user input

-- Task 1
INSERT INTO Bookings(BookingID, BookingDate, TableNumber, CustomerID, NumberOfGuests)
VALUES 
(1, '2023-10-10', 5, 1, 4),
(2, '2023-10-12', 3, 3, 2),
(3, '2023-10-11', 2, 2, 4),
(4, '2023-10-13', 2, 1, 2);

-- Task 2
DROP PROCEDURE IF EXISTS CheckBooking ;
DELIMITER //
CREATE PROCEDURE CheckBooking(book_date VARCHAR(10), table_num INT)
BEGIN
  DECLARE already_booked INT;
  DECLARE BookingStatus VARCHAR(30);
  SET already_booked = 0;
  SELECT 1 INTO already_booked FROM Bookings WHERE BookingDate = book_date AND TableNumber = table_num;
  IF already_booked = 1 THEN
    SET BookingStatus = CONCAT("Table ", table_num, " is already booked");
  ELSE SET BookingStatus = CONCAT("Table ", table_num, " is available");
  END IF;
  SELECT BookingStatus AS 'Booking status';
END //
DELIMITER ;

CALL CheckBooking('2023-10-12', 3);

CALL CheckBooking('2023-10-12', 1);

-- Task 3

-- NOTE: CustomerID is NOT NULL, Thus it must be passed as a third parameter

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(book_date VARCHAR(10), table_num INT, cust_id INT)
BEGIN
  DECLARE already_booked INT;
  DECLARE BookingStatus VARCHAR(50);
  DECLARE book_id INT;
  SET already_booked = 0;
  SELECT MAX(BookingID) + 1 INTO book_id FROM Bookings;
  START TRANSACTION;
  INSERT INTO Bookings(BookingID, BookingDate, TableNumber, CustomerID)
  VALUES (book_id, book_date, table_num, cust_id);
  SELECT count(*) INTO already_booked FROM Bookings WHERE BookingDate = book_date AND TableNumber = table_num;
  IF already_booked > 1 THEN
    ROLLBACK;
    SET BookingStatus = CONCAT("Table ", table_num, " is already booked - booking cancelled");
  ELSE
    COMMIT;
    SET BookingStatus = CONCAT("Table ", table_num, " successfully booked");
  END IF;
  SELECT BookingStatus AS 'Booking status';
END //
DELIMITER ;

-- NOTE: CustomerID is a required FK in Bookings, therefore it must be passes as the third parameter
CALL AddValidBooking('2023-10-11', 2, 5);

CALL AddValidBooking('2023-10-14', 2, 5);

SELECT * FROM Bookings;
