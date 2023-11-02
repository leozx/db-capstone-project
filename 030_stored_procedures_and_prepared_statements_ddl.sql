USE LittleLemonDB;

-- Create optimized queries to manage and analyze data

-- Task 1

DROP PROCEDURE  IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity ()
BEGIN
SELECT MAX(Quantity) AS 'Max Quantity in Order' FROM Orders;
END //
DELIMITER ;

CALL GetMaxQuantity();

-- Task 2

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE OrderID IN (?)';

SET @id = 1;

EXECUTE GetOrderDetail USING @id;

-- Task 3
SELECT 1 AS Found FROM Orders WHERE OrderID = 6;

DROP PROCEDURE  IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(id INT)
BEGIN
  DECLARE Found INT;
  DECLARE Confirmation VARCHAR(30);
  SET Found = 0;
  SELECT 1 INTO Found FROM Orders WHERE OrderID = id;
  IF Found = 1 THEN
    DELETE FROM Orders WHERE OrderID = id;
    SET Confirmation = CONCAT("Order ", id, " is cancelled");
  ELSE SET Confirmation = CONCAT("Order ", id, " NOT FOUND");
  END IF;
  SELECT Confirmation;
END //
DELIMITER ;
