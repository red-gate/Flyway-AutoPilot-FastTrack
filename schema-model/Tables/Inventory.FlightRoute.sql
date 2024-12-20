CREATE TABLE [Inventory].[FlightRoute]
(
[RouteID] [int] NOT NULL IDENTITY(1, 1),
[DepartureCity] [nvarchar] (50) NOT NULL,
[ArrivalCity] [nvarchar] (50) NOT NULL,
[Distance] [int] NOT NULL
)
GO
ALTER TABLE [Inventory].[FlightRoute] ADD PRIMARY KEY CLUSTERED ([RouteID])
GO
