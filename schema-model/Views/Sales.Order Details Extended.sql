SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[Order Details Extended]
AS
SELECT od.OrderID, od.ProductID, p.ProductName, od.UnitPrice, od.Quantity, od.Discount, (CONVERT(MONEY, (od.UnitPrice * od.Quantity *(1-od.Discount)/ 100))* 100) AS ExtendedPrice
FROM Operation.Products p
     INNER JOIN "Order Details" od ON p.ProductID=od.ProductID;
--ORDER BY od.OrderID
GO
