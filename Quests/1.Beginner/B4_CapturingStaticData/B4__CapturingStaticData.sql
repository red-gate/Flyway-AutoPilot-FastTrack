-- Migration Script: Capturing Static Data for Customers.LoyaltyProgram

-- NOTE: Use the Flyway configuration "flyway.skipExecutingMigrations" 
-- to track this script without executing its contents in Test/Prod environments (In the scenario where the data ALREADY exists in upper stages).

-- This script represents the initial capture of static data in the Customers.LoyaltyProgram table.

INSERT INTO Customers.LoyaltyProgram (ProgramName, PointsMultiplier)
VALUES
    ('Silver', '1.00'),
    ('Gold', '1.50'),
    ('Platinum', '2.00');

-- End of Script
