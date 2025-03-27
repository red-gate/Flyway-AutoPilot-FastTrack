SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[CustomerOrdersView]
AS
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.Address, c.City, c.Region, c.Phone
FROM Sales.Customers c
     JOIN Sales.Orders o ON c.CustomerID=o.CustomerID;
GO
