-- Migration Script: Capturing Static Data for Customers.LoyaltyProgram

-- NOTE: Use the Flyway configuration "flyway.skipExecutingMigrations" 
-- to track this script without executing its contents in Test/Prod environments (In the scenario where the data ALREADY exists in upper stages).

-- This script represents the initial capture of static data in the Customers.LoyaltyProgram table.

INSERT INTO Customers.LoyaltyProgram (ProgramID, ProgramName, RewardPointsRequired)
VALUES
    (1, 'Gold', 1000),
    (2, 'Silver', 500),
    (3, 'Bronze', 250);

-- End of Script
