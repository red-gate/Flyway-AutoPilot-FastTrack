-- Add unique constraint for DepartureCity and ArrivalCity
ALTER TABLE Inventory.FlightRoute
ADD CONSTRAINT UQ_FlightRoute_DepartureArrival UNIQUE (DepartureCity, ArrivalCity);
