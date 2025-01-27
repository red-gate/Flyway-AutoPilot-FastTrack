-- Create partition function
CREATE PARTITION FUNCTION MaintenanceYearPartition (DATETIME)
AS RANGE LEFT FOR VALUES ('2020-01-01', '2021-01-01', '2022-01-01', '2023-01-01');

-- Create partition scheme
CREATE PARTITION SCHEME MaintenanceScheme
AS PARTITION MaintenanceYearPartition ALL TO ([PRIMARY]);

-- Recreate the table with partitioning
CREATE TABLE Inventory.MaintenanceLog (
    LogID INT PRIMARY KEY IDENTITY,
    FlightID INT FOREIGN KEY REFERENCES Inventory.Flight(FlightID),
    MaintenanceDate DATETIME,
    Description NVARCHAR(500),
    MaintenanceStatus NVARCHAR(20) DEFAULT 'Pending'
) ON MaintenanceScheme(MaintenanceDate);
