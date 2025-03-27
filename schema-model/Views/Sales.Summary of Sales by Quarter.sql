SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[Summary of Sales by Quarter]
AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders
     INNER JOIN "Order Subtotals" ON Orders.OrderID="Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL;
--ORDER BY Orders.ShippedDate
GO
