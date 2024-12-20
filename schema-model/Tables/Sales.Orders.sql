CREATE TABLE [Sales].[Orders]
(
[OrderID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[FlightID] [int] NULL,
[OrderDate] [datetime] NULL DEFAULT (getdate()),
[Status] [nvarchar] (20) NULL DEFAULT ('Pending'),
[TotalAmount] [decimal] (10, 2) NULL,
[TicketQuantity] [int] NULL
)
GO
ALTER TABLE [Sales].[Orders] ADD PRIMARY KEY CLUSTERED ([OrderID])
GO
ALTER TABLE [Sales].[Orders] ADD FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
ALTER TABLE [Sales].[Orders] ADD FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
