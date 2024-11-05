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
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [PK__Orders__C3905BAF620C2D5C] PRIMARY KEY CLUSTERED ([OrderID])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK__Orders__Customer__36B12243] FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK__Orders__FlightID__37A5467C] FOREIGN KEY ([FlightID]) REFERENCES [Inventory].[Flight] ([FlightID])
GO
