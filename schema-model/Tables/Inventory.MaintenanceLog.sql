CREATE TABLE [Inventory].[MaintenanceLog]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[FlightID] [int] NULL,
[MaintenanceDate] [datetime] NULL DEFAULT (getdate()),
[Description] [nvarchar] (500) NULL,
[MaintenanceStatus] [nvarchar] (20) NULL DEFAULT ('Pending')
)
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD PRIMARY KEY CLUSTERED ([LogID])
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
