CREATE PROCEDURE Inventory.GetUpcomingFlights
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT *
    FROM Inventory.Flight
    WHERE DepartureTime BETWEEN @StartDate AND @EndDate;
END;
