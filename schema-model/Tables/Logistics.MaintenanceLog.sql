CREATE TABLE [Logistics].[MaintenanceLog]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[FlightID] [int] NULL,
[MaintenanceDate] [datetime] NULL CONSTRAINT [DF__Maintenan__Maint__31EC6D26] DEFAULT (getdate()),
[Description] [nvarchar] (500) NULL,
[MaintenanceStatus] [nvarchar] (20) NULL CONSTRAINT [DF__Maintenan__Maint__32E0915F] DEFAULT ('Pending')
)
GO
ALTER TABLE [Logistics].[MaintenanceLog] ADD CONSTRAINT [PK__Maintena__5E5499A8A7E7CD24] PRIMARY KEY CLUSTERED ([LogID])
GO
ALTER TABLE [Logistics].[MaintenanceLog] ADD CONSTRAINT [FK__Maintenan__Fligh__30F848ED] FOREIGN KEY ([FlightID]) REFERENCES [Logistics].[Flight] ([FlightID])
GO
