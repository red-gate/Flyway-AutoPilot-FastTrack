-- A3_AddPartitioned.sql
-- Adding Partitioning to Inventory.MaintenanceLog table

-- Check if the partition function and schema already exist; create them if they do not
IF NOT EXISTS (SELECT * FROM sys.partition_functions WHERE name = 'MaintenanceDateRange')
BEGIN
    -- Create a partition function to partition by MaintenanceDate
    CREATE PARTITION FUNCTION MaintenanceDateRange(DATETIME) 
    AS RANGE RIGHT FOR VALUES ('2024-01-01', '2024-06-01', '2024-12-31');
END;

IF NOT EXISTS (SELECT * FROM sys.partition_schemes WHERE name = 'MaintenanceScheme')
BEGIN
    -- Create a partition scheme using the partition function
    CREATE PARTITION SCHEME MaintenanceScheme 
    AS PARTITION MaintenanceDateRange ALL TO ([PRIMARY]);
END;

-- Add partitioning to the MaintenanceLog table
-- First, ensure the table does not already exist
IF OBJECT_ID('Inventory.MaintenanceLog', 'U') IS NOT NULL
BEGIN
    PRINT 'Recreating Inventory.MaintenanceLog with partitioning.';
    
    -- Drop the temporary table if it exists
    IF OBJECT_ID('tempdb..#TempMaintenanceLog', 'U') IS NOT NULL
    BEGIN
        DROP TABLE #TempMaintenanceLog;
    END;

    -- Move data to a temporary table
    SELECT *
    INTO #TempMaintenanceLog
    FROM Inventory.MaintenanceLog;

    -- Drop the original table
    DROP TABLE Inventory.MaintenanceLog;

    -- Recreate the table with partitioning
    CREATE TABLE Inventory.MaintenanceLog (
        LogID INT NOT NULL,
        FlightID INT NOT NULL FOREIGN KEY REFERENCES Inventory.Flight(FlightID),
        MaintenanceDate DATETIME NOT NULL,
        Description NVARCHAR(500),
        MaintenanceStatus NVARCHAR(20) DEFAULT 'Pending',
        CONSTRAINT PK_MaintenanceLog PRIMARY KEY (MaintenanceDate, LogID) -- Include MaintenanceDate in PK
    ) ON MaintenanceScheme(MaintenanceDate);

    -- Insert data back from the temporary table
    INSERT INTO Inventory.MaintenanceLog (LogID, FlightID, MaintenanceDate, Description, MaintenanceStatus)
    SELECT LogID, FlightID, MaintenanceDate, Description, MaintenanceStatus
    FROM #TempMaintenanceLog;

    -- Drop the temporary table
    DROP TABLE #TempMaintenanceLog;
END
ELSE
BEGIN
    -- If the table does not exist, create it with partitioning directly
    CREATE TABLE Inventory.MaintenanceLog (
        LogID INT NOT NULL,
        FlightID INT NOT NULL FOREIGN KEY REFERENCES Inventory.Flight(FlightID),
        MaintenanceDate DATETIME NOT NULL,
        Description NVARCHAR(500),
        MaintenanceStatus NVARCHAR(20) DEFAULT 'Pending',
        CONSTRAINT PK_MaintenanceLog PRIMARY KEY (MaintenanceDate, LogID) -- Include MaintenanceDate in PK
    ) ON MaintenanceScheme(MaintenanceDate);
END;

PRINT 'Partitioning setup for Inventory.MaintenanceLog is complete.';
