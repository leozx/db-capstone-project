-- Create SQL queries to add and update bookings

USE LittleLemonDB;

-- Task 1

DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(book_id INT, cust_id INT, table_num INT, book_date VARCHAR(10))
BEGIN
  DECLARE already_booked INT;
  DECLARE Confirmation VARCHAR(50);
  SET already_booked = 0;
  SELECT count(*) INTO already_booked FROM Bookings WHERE BookingDate = book_date AND TableNumber = table_num;
  IF already_booked > 0 THEN
    SET Confirmation = CONCAT("Table ", table_num, " is already booked - booking cancelled");
  ELSE
    INSERT INTO Bookings(BookingID, BookingDate, TableNumber, CustomerID)
    VALUES (book_id, book_date, table_num, cust_id);
    SET Confirmation = CONCAT("New booking added");
  END IF;
  SELECT Confirmation;
END //
DELIMITER ;

CALL AddBooking(7, 3, 4, '2023-11-30');

SELECT * FROM Bookings;

-- Task 2
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(book_id INT, book_date VARCHAR(10))
BEGIN
  DECLARE Found INT;
  DECLARE Confirmation VARCHAR(50);
  SET Found = 0;
  SELECT 1 INTO Found FROM Bookings WHERE BookingID = book_id;
  IF Found = 1 THEN
    UPDATE Bookings SET BookingDate = book_date WHERE BookingID = book_id;
    SET Confirmation = CONCAT("Booking ", book_id, " updated");
  ELSE
    SET Confirmation = CONCAT("Booking ", book_id, " NOT found");
  END IF;
  SELECT Confirmation;
END //
DELIMITER ;

CALL UpdateBooking(7, '2023-11-10');

CALL UpdateBooking(6, '2023-11-10');

SELECT * FROM Bookings;

-- Task 3

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(book_id INT)
BEGIN
  DECLARE Found INT;
  DECLARE Confirmation VARCHAR(50);
  SET Found = 0;
  SELECT 1 INTO Found FROM Bookings WHERE BookingID = book_id;
  IF Found = 1 THEN
    DELETE FROM Bookings WHERE BookingID = book_id;
    SET Confirmation = CONCAT("Booking ", book_id, " cancelled");
  ELSE
    SET Confirmation = CONCAT("Booking ", book_id, " NOT found");
  END IF;
  SELECT Confirmation;
END //
DELIMITER ;

CALL CancelBooking(7);

CALL CancelBooking(7);

SELECT * FROM Bookings;

