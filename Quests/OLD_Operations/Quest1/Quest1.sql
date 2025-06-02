-- This script creates pending objects under the 'Marketing' schema (to be included)
-- and the 'Finance' schema (which should be excluded when generating migrations).

-- Objects that should be included in the migration:
CREATE TABLE Marketing.CustomerFeedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    FeedbackText NVARCHAR(500) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Marketing.CampaignAnalytics (
    CampaignID INT PRIMARY KEY,
    ClickThroughRate DECIMAL(5,2) NOT NULL,
    ConversionRate DECIMAL(5,2) NOT NULL,
    AdSpend MONEY NOT NULL
);

CREATE PROCEDURE Marketing.GetCustomerFeedback
    @CustomerID INT
AS
BEGIN
    SELECT FeedbackText, Rating, CreatedAt
    FROM Marketing.CustomerFeedback
    WHERE CustomerID = @CustomerID;
END;

CREATE FUNCTION Marketing.GetAverageCampaignCTR(@CampaignID INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @AvgCTR DECIMAL(5,2);
    SELECT @AvgCTR = AVG(ClickThroughRate)
    FROM Marketing.CampaignAnalytics
    WHERE CampaignID = @CampaignID;
    RETURN @AvgCTR;
END;

-- Objects that should NOT be included in the migration:
CREATE TABLE Finance.BudgetAllocations (
    BudgetID INT PRIMARY KEY,
    Department NVARCHAR(100) NOT NULL,
    AllocatedAmount MONEY NOT NULL
);

CREATE PROCEDURE Finance.GetBudgetForDepartment
    @Department NVARCHAR(100)
AS
BEGIN
    SELECT AllocatedAmount FROM Finance.BudgetAllocations
    WHERE Department = @Department;
END;
