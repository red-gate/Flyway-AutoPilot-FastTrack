CREATE TABLE [dbo].[MissionDetail]
(
[Mission] [varchar] (255) NOT NULL,
[LogicalDestinationID] [varchar] (32) NOT NULL,
[WaveID] [varchar] (32) NOT NULL,
[OrderID] [varchar] (32) NOT NULL,
[ShipmentID] [varchar] (32) NOT NULL,
[ConsolidationID] [varchar] (255) NOT NULL,
[PickTaskID] [varchar] (50) NULL,
[Priority] [int] NULL,
[CreatedTime] [datetime2] (3) NOT NULL,
[Status] [int] NULL,
[StatusTime] [datetime2] (3) NULL,
[Expected] [int] NULL,
[Dispatched] [int] NULL,
[Diverted] [int] NULL,
[EOWFlag] [varchar] (3) NULL,
[LastUpdateTime] [datetime2] (3) NOT NULL,
[RecordID] [bigint] NOT NULL IDENTITY(1, 1),
[Finished] AS (case  when [Status]=(100) OR [Status]=(75) then (1) else (0) end) PERSISTED NOT NULL
)
GO
