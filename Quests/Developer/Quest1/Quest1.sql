-- Step 1: Create the initial table
CREATE TABLE Sales.Campaigns (
    CampaignID INT PRIMARY KEY,
    CampaignName NVARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

-- Step 2: Create a stored procedure that depends on the table
CREATE PROCEDURE Sales.GetActiveCampaigns
AS
BEGIN
    SELECT CampaignID, CampaignName, StartDate, EndDate
    FROM Sales.Campaigns
    WHERE StartDate <= GETDATE() AND EndDate >= GETDATE();
END;

-- Step 3: Simulate the problem by renaming the table (breaking the stored procedure)
EXEC sp_rename 'Sales.Campaigns', 'Promotions';
