SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Stored Procedures

CREATE PROCEDURE [Sales].[GetCustomerFlightHistory] @CustomerID INT
AS
BEGIN
    SELECT 
        o.OrderID,
        f.Airline,
        f.DepartureCity,
        f.ArrivalCity,
        o.OrderDate,
        o.Status,
        o.TotalAmount
    FROM Sales.Orders o
    JOIN Inventory.Flight f ON o.FlightID = f.FlightID
    WHERE o.CustomerID = @CustomerID
    ORDER BY o.OrderDate;
END;
GO
