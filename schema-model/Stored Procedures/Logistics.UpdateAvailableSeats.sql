SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Logistics].[UpdateAvailableSeats] @FlightID INT, @SeatChange INT
AS BEGIN
    UPDATE Logistics.Flight
    SET AvailableSeats=AvailableSeats+@SeatChange
    WHERE FlightID=@FlightID;
END;
GO
