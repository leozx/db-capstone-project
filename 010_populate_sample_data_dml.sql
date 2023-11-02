USE LittleLemonDB;

INSERT INTO Customers(CustomerID, FullName, ContactNumber, Email) VALUES
(1, 'Vanessa McCarthy', 876543201, 'vanessa@mail.com'),
(2, 'Marcos Romero', 876543202, 'marcos@mail.com'),
(3, 'Anna Iversen', 876543203, 'anna@mail.com'),
(4, 'Joakim Iversen', 876543204, 'joakim@mail.com'),
(5, 'Hiroki Yamane', 876543205, 'hiroki@mail.com');

INSERT INTO MenuItems(MenuItemsID, CourseName) VALUES
(1, 'Kabasa'),
(2, 'Greek Salad'),
(3, 'Scargot'),
(4, 'Fetuccini');

INSERT INTO Menus(MenuID, MenuItemsID, MenuName, Cuisine) VALUES
(1, 1, 'Manti', 'Indian'),
(2, 2, 'Moussaka', 'Greek'),
(3, 3, 'Gusteau', 'French'),
(4, 4, 'Pasta', 'Italian');

INSERT INTO Orders(OrderID, MenuID, CustomerID, Quantity, Cost, OrderDate)
VALUES
(1, 1, 1, 5, 50.00, CURRENT_DATE()),
(2, 2, 2, 4, 40.00, CURRENT_DATE()),
(3, 3, 3, 1, 10.00, CURRENT_DATE()),
(4, 4, 4, 2, 20.00, CURRENT_DATE()),
(5, 2, 5, 3, 30.00, CURRENT_DATE());
