-- Add computed column
ALTER TABLE Inventory.Flight
ADD FlightDuration AS DATEDIFF(MINUTE, DepartureTime, ArrivalTime);

-- Create an index on the computed column
CREATE INDEX IX_Flight_FlightDuration
ON Inventory.Flight (FlightDuration);
