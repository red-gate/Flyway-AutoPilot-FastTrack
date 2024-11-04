CREATE TABLE [Inventory].[MaintenanceLog]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[FlightID] [int] NULL,
[MaintenanceDate] [datetime] NULL CONSTRAINT [DF__Maintenan__Maint__32E0915F] DEFAULT (getdate()),
[Description] [nvarchar] (500) NULL,
[MaintenanceStatus] [nvarchar] (20) NULL CONSTRAINT [DF__Maintenan__Maint__33D4B598] DEFAULT ('Pending')
)
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD CONSTRAINT [PK__Maintena__5E5499A88B04184F] PRIMARY KEY CLUSTERED ([LogID])
GO
ALTER TABLE [Inventory].[MaintenanceLog] ADD CONSTRAINT [FK__Maintenan__Fligh__31EC6D26] FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
