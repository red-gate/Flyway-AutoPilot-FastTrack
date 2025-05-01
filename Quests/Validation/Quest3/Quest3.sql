CREATE PROCEDURE Inventory.GetUpcomingFlights
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT FlightID,
           Airline,
           DepartureCity,
           ArrivalCity,
           DepartureTime,
           ArrivalTime,
           Price,
           AvailableSeats
    FROM Inventory.Flight
    WHERE DepartureTime BETWEEN @StartDate AND @EndDate;
END;
