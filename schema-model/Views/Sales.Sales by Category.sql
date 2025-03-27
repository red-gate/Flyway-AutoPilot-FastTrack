SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[Sales by Category]
AS
SELECT Operation.Categories.CategoryID, Operation.Categories.CategoryName, Operation.Products.ProductName, SUM("Order Details Extended".ExtendedPrice) AS ProductSales
FROM Operation.Categories
     INNER JOIN(Operation.Products
                INNER JOIN(Orders
                           INNER JOIN "Order Details Extended" ON Orders.OrderID="Order Details Extended".OrderID)ON Operation.Products.ProductID="Order Details Extended".ProductID)ON Operation.Categories.CategoryID=Operation.Products.CategoryID
WHERE Orders.OrderDate BETWEEN '19970101' AND '19971231'
GROUP BY Operation.Categories.CategoryID, Operation.Categories.CategoryName, Operation.Products.ProductName;
--ORDER BY Operation.Products.ProductName
GO
