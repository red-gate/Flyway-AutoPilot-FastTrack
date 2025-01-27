ALTER VIEW Sales.CustomerOrdersView AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.Status,
    o.TotalAmount,
    o.TicketQuantity
FROM Customers.Customer c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID;
