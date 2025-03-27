SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[Order Subtotals]
AS
SELECT "Order Details".OrderID, SUM(CONVERT(MONEY, ("Order Details".UnitPrice * Quantity *(1-Discount)/ 100))* 100) AS Subtotal
FROM "Order Details"
GROUP BY "Order Details".OrderID;
GO
