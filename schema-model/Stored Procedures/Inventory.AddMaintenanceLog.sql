SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Inventory].[AddMaintenanceLog]
    @FlightID INT,
    @Description NVARCHAR(500)
AS
BEGIN
    INSERT INTO Inventory.MaintenanceLog (FlightID, Description, MaintenanceStatus)
    VALUES (@FlightID, @Description, 'Pending');

    PRINT 'Maintenance log entry created.';
END;
GO
