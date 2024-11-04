SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Inventory].[UpdateAvailableSeats]
    @FlightID INT,
    @SeatChange INT
AS
BEGIN
    UPDATE Inventory.Flight
    SET AvailableSeats = AvailableSeats + @SeatChange
    WHERE FlightID = @FlightID;
END;
GO
