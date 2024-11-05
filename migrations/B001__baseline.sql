SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating schemas'
GO
IF SCHEMA_ID(N'Customers') IS NULL
EXEC sp_executesql N'CREATE SCHEMA [Customers]
AUTHORIZATION [dbo]'
GO
IF SCHEMA_ID(N'Inventory') IS NULL
EXEC sp_executesql N'CREATE SCHEMA [Inventory]
AUTHORIZATION [dbo]'
GO
IF SCHEMA_ID(N'Sales') IS NULL
EXEC sp_executesql N'CREATE SCHEMA [Sales]
AUTHORIZATION [dbo]'
GO
PRINT N'Creating [Customers].[CustomerFeedback]'
GO
CREATE TABLE [Customers].[CustomerFeedback]
(
[FeedbackID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[FeedbackDate] [datetime] NULL CONSTRAINT [DF__CustomerF__Feedb__2A4B4B5E] DEFAULT (getdate()),
[Rating] [int] NULL,
[Comments] [nvarchar] (500) NULL
)
GO
PRINT N'Creating primary key [PK__Customer__6A4BEDF63E215A69] on [Customers].[CustomerFeedback]'
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [PK__Customer__6A4BEDF63E215A69] PRIMARY KEY CLUSTERED ([FeedbackID])
GO
PRINT N'Creating [Customers].[LoyaltyProgram]'
GO
CREATE TABLE [Customers].[LoyaltyProgram]
(
[ProgramID] [int] NOT NULL IDENTITY(1, 1),
[ProgramName] [nvarchar] (50) NOT NULL,
[PointsMultiplier] [decimal] (3, 2) NULL CONSTRAINT [DF__LoyaltyPr__Point__267ABA7A] DEFAULT ((1.0))
)
GO
PRINT N'Creating primary key [PK__LoyaltyP__75256038C93BE3A7] on [Customers].[LoyaltyProgram]'
GO
ALTER TABLE [Customers].[LoyaltyProgram] ADD CONSTRAINT [PK__LoyaltyP__75256038C93BE3A7] PRIMARY KEY CLUSTERED ([ProgramID])
GO
PRINT N'Creating [Inventory].[MaintenanceLog]'
GO
CREATE TABLE [Inventory].[MaintenanceLog]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[FlightID] [int] NULL,
[MaintenanceDate] [datetime] NULL CONSTRAINT [DF__Maintenan__Maint__32E0915F] DEFAULT (getdate()),
[Description] [nvarchar] (500) NULL,
[MaintenanceStatus] [nvarchar] (20) NULL CONSTRAINT [DF__Maintenan__Maint__33D4B598] DEFAULT ('Pending')
)
GO
PRINT N'Creating primary key [PK__Maintena__5E5499A88B04184F] on [Inventory].[MaintenanceLog]'
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD CONSTRAINT [PK__Maintena__5E5499A88B04184F] PRIMARY KEY CLUSTERED ([LogID])
GO
PRINT N'Creating [Sales].[OrderAuditLog]'
GO
CREATE TABLE [Sales].[OrderAuditLog]
(
[AuditID] [int] NOT NULL IDENTITY(1, 1),
[OrderID] [int] NULL,
[ChangeDate] [datetime] NULL CONSTRAINT [DF__OrderAudi__Chang__412EB0B6] DEFAULT (getdate()),
[ChangeDescription] [nvarchar] (500) NULL
)
GO
PRINT N'Creating primary key [PK__OrderAud__A17F23B8237E8CF2] on [Sales].[OrderAuditLog]'
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD CONSTRAINT [PK__OrderAud__A17F23B8237E8CF2] PRIMARY KEY CLUSTERED ([AuditID])
GO
PRINT N'Creating [Sales].[Orders]'
GO
CREATE TABLE [Sales].[Orders]
(
[OrderID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[FlightID] [int] NULL,
[OrderDate] [datetime] NULL CONSTRAINT [DF__Orders__OrderDat__38996AB5] DEFAULT (getdate()),
[Status] [nvarchar] (20) NULL CONSTRAINT [DF__Orders__Status__398D8EEE] DEFAULT ('Pending'),
[TotalAmount] [decimal] (10, 2) NULL,
[TicketQuantity] [int] NULL
)
GO
PRINT N'Creating primary key [PK__Orders__C3905BAF620C2D5C] on [Sales].[Orders]'
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [PK__Orders__C3905BAF620C2D5C] PRIMARY KEY CLUSTERED ([OrderID])
GO
PRINT N'Creating [Customers].[Customer]'
GO
CREATE TABLE [Customers].[Customer]
(
[CustomerID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) NOT NULL,
[LastName] [nvarchar] (50) NOT NULL,
[Email] [nvarchar] (100) NOT NULL,
[DateOfBirth] [date] NULL,
[Phone] [nvarchar] (20) NULL,
[Address] [nvarchar] (200) NULL
)
GO
PRINT N'Creating primary key [PK__Customer__A4AE64B82992B4E4] on [Customers].[Customer]'
GO
ALTER TABLE [Customers].[Customer] ADD CONSTRAINT [PK__Customer__A4AE64B82992B4E4] PRIMARY KEY CLUSTERED ([CustomerID])
GO
PRINT N'Adding constraints to [Customers].[Customer]'
GO
ALTER TABLE [Customers].[Customer] ADD CONSTRAINT [UQ__Customer__A9D10534B17A14F8] UNIQUE NONCLUSTERED ([Email])
GO
PRINT N'Creating [Inventory].[Flight]'
GO
CREATE TABLE [Inventory].[Flight]
(
[FlightID] [int] NOT NULL IDENTITY(1, 1),
[Airline] [nvarchar] (50) NOT NULL,
[DepartureCity] [nvarchar] (50) NOT NULL,
[ArrivalCity] [nvarchar] (50) NOT NULL,
[DepartureTime] [datetime] NOT NULL,
[ArrivalTime] [datetime] NOT NULL,
[Price] [decimal] (10, 2) NOT NULL,
[AvailableSeats] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK__Flight__8A9E148EB937FB76] on [Inventory].[Flight]'
GO
ALTER TABLE [Inventory].[Flight] ADD CONSTRAINT [PK__Flight__8A9E148EB937FB76] PRIMARY KEY CLUSTERED ([FlightID])
GO
PRINT N'Creating [Customers].[RecordFeedback]'
GO

CREATE PROCEDURE [Customers].[RecordFeedback]
    @CustomerID INT,
    @Rating INT,
    @Comments NVARCHAR(500)
AS
BEGIN
    INSERT INTO Customers.CustomerFeedback (CustomerID, Rating, Comments)
    VALUES (@CustomerID, @Rating, @Comments);

    PRINT 'Customer feedback recorded successfully.';
END;
GO
PRINT N'Creating [Inventory].[AddMaintenanceLog]'
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
PRINT N'Creating [Inventory].[UpdateAvailableSeats]'
GO

CREATE PROCEDURE [Inventory].[UpdateAvailableSeats]
    @FlightID INT,
    @SeatChange INT
AS
BEGIN
    UPDATE Inventory.Flight
    SET AvailableSeats = AvailableSeats + @SeatChange
    WHERE FlightID = @FlightID;
END;
GO
PRINT N'Creating [Sales].[DiscountCode]'
GO
CREATE TABLE [Sales].[DiscountCode]
(
[DiscountID] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (20) NOT NULL,
[DiscountPercentage] [decimal] (4, 2) NULL,
[ExpiryDate] [datetime] NULL
)
GO
PRINT N'Creating primary key [PK__Discount__E43F6DF6AB26F780] on [Sales].[DiscountCode]'
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [PK__Discount__E43F6DF6AB26F780] PRIMARY KEY CLUSTERED ([DiscountID])
GO
PRINT N'Adding constraints to [Sales].[DiscountCode]'
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [UQ__Discount__A25C5AA7D45A51FC] UNIQUE NONCLUSTERED ([Code])
GO
PRINT N'Creating [Sales].[ApplyDiscount]'
GO

CREATE PROCEDURE [Sales].[ApplyDiscount]
    @OrderID INT,
    @DiscountCode NVARCHAR(20)
AS
BEGIN
    DECLARE @DiscountID INT, @DiscountPercentage DECIMAL(4, 2), @ExpiryDate DATETIME;
    
    SELECT 
        @DiscountID = DiscountID,
        @DiscountPercentage = DiscountPercentage,
        @ExpiryDate = ExpiryDate
    FROM Sales.DiscountCode
    WHERE Code = @DiscountCode;
    
    IF @DiscountID IS NOT NULL AND @ExpiryDate >= GETDATE()
    BEGIN
        UPDATE Sales.Orders
        SET TotalAmount = TotalAmount * (1 - @DiscountPercentage / 100)
        WHERE OrderID = @OrderID;

        INSERT INTO Sales.OrderAuditLog (OrderID, ChangeDescription)
        VALUES (@OrderID, CONCAT('Discount ', @DiscountCode, ' applied with ', @DiscountPercentage, '% off.'));
    END
    ELSE
    BEGIN
        RAISERROR('Invalid or expired discount code.', 16, 1);
    END
END;
GO
PRINT N'Creating [Sales].[GetCustomerFlightHistory]'
GO

-- Stored Procedures

CREATE PROCEDURE [Sales].[GetCustomerFlightHistory] @CustomerID INT
AS
BEGIN
    SELECT 
        o.OrderID,
        f.Airline,
        f.DepartureCity,
        f.ArrivalCity,
        o.OrderDate,
        o.Status,
        o.TotalAmount
    FROM Sales.Orders o
    JOIN Inventory.Flight f ON o.FlightID = f.FlightID
    WHERE o.CustomerID = @CustomerID
    ORDER BY o.OrderDate;
END;
GO
PRINT N'Creating [Sales].[UpdateOrderStatus]'
GO

CREATE PROCEDURE [Sales].[UpdateOrderStatus]
    @OrderID INT,
    @NewStatus NVARCHAR(20)
AS
BEGIN
    UPDATE Sales.Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;
END;
GO
PRINT N'Creating [Customers].[CustomerFeedbackSummary]'
GO

CREATE VIEW [Customers].[CustomerFeedbackSummary] AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    AVG(f.Rating) AS AverageRating,
    COUNT(f.FeedbackID) AS FeedbackCount
FROM Customers.Customer c
LEFT JOIN Customers.CustomerFeedback f ON c.CustomerID = f.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
GO
PRINT N'Creating [Inventory].[FlightMaintenanceStatus]'
GO

CREATE VIEW [Inventory].[FlightMaintenanceStatus] AS
SELECT 
    f.FlightID,
    f.Airline,
    f.DepartureCity,
    f.ArrivalCity,
    COUNT(m.LogID) AS MaintenanceCount,
    SUM(CASE WHEN m.MaintenanceStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedMaintenance
FROM Inventory.Flight f
LEFT JOIN Inventory.MaintenanceLog m ON f.FlightID = m.FlightID
GROUP BY f.FlightID, f.Airline, f.DepartureCity, f.ArrivalCity;
GO
PRINT N'Creating [Sales].[CustomerOrdersView]'
GO
CREATE VIEW [Sales].[CustomerOrdersView] AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.Status,
    o.TotalAmount
FROM Customers.Customer c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID;
GO
PRINT N'Creating [Inventory].[FlightRoute]'
GO
CREATE TABLE [Inventory].[FlightRoute]
(
[RouteID] [int] NOT NULL IDENTITY(1, 1),
[DepartureCity] [nvarchar] (50) NOT NULL,
[ArrivalCity] [nvarchar] (50) NOT NULL,
[Distance] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK__FlightRo__80979AAD7FA082B5] on [Inventory].[FlightRoute]'
GO
ALTER TABLE [Inventory].[FlightRoute] ADD CONSTRAINT [PK__FlightRo__80979AAD7FA082B5] PRIMARY KEY CLUSTERED ([RouteID])
GO
PRINT N'Adding constraints to [Customers].[CustomerFeedback]'
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [CK__CustomerF__Ratin__2B3F6F97] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding constraints to [Sales].[DiscountCode]'
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [CK__DiscountC__Disco__3D5E1FD2] CHECK (([DiscountPercentage]>=(0) AND [DiscountPercentage]<=(100)))
GO
PRINT N'Adding foreign keys to [Customers].[CustomerFeedback]'
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [FK__CustomerF__Custo__29572725] FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
PRINT N'Adding foreign keys to [Sales].[Orders]'
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK__Orders__Customer__36B12243] FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK__Orders__FlightID__37A5467C] FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
PRINT N'Adding foreign keys to [Inventory].[MaintenanceLog]'
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD CONSTRAINT [FK__Maintenan__Fligh__31EC6D26] FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
PRINT N'Adding foreign keys to [Sales].[OrderAuditLog]'
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD CONSTRAINT [FK__OrderAudi__Order__403A8C7D] FOREIGN KEY ([OrderID]) REFERENCES [Sales].[Orders] ([OrderID])
GO

