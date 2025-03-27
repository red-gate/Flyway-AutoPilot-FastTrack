CREATE TABLE [Logistics].[Shippers]
(
[ShipperID] [int] NOT NULL IDENTITY(1, 1),
[CompanyName] [nvarchar] (40) NOT NULL,
[Phone] [nvarchar] (24) NULL,
[id] [int] NULL,
[ShipId] [int] NULL
)
GO
ALTER TABLE [Logistics].[Shippers] ADD CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperID])
GO
