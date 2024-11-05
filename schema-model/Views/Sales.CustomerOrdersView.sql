SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [Sales].[CustomerOrdersView] AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.Status,
    o.TotalAmount
FROM Customers.Customer c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID;
GO
