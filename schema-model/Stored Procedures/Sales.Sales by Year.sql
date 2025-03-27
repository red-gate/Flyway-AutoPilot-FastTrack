SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Sales].[Sales by Year] @Beginning_Date DATETIME, @Ending_Date DATETIME
AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy, ShippedDate) AS Year
FROM Orders
     INNER JOIN "Order Subtotals" ON Orders.OrderID="Order Subtotals".OrderID
WHERE Orders.ShippedDate BETWEEN @Beginning_Date AND @Ending_Date;
GO
