ALTER TABLE Inventory.Flight
ADD CONSTRAINT CHK_AvailableSeats_Positive CHECK (AvailableSeats > 0);
