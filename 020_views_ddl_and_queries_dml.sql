USE LittleLemonDB;

-- Create a virtual table to summarize data

-- Task 1
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders;

SELECT * FROM OrdersView;

-- Task 2
SELECT c.CustomerID, c.FullName, o.OrderID, o.Cost, m.MenuName, i.CourseName
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN Menus m ON m.MenuID = o.MenuID
INNER JOIN MenuItems i ON i.MenuItemsID = m.MenuItemsID;

-- Task 3
SELECT MenuName FROM Menus WHERE MenuID  = ANY(SELECT MenuID FROM Orders WHERE Quantity > 2);
