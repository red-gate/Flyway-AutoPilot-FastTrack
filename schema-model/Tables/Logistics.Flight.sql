CREATE TABLE [Logistics].[Flight]
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
ALTER TABLE [Logistics].[Flight] ADD CONSTRAINT [PK__Flight__8A9E148E9A8ED149] PRIMARY KEY CLUSTERED ([FlightID])
GO
