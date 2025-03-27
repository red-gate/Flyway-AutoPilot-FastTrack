CREATE TABLE [Sales].[Orders]
(
[OrderID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [nchar] (5) NULL,
[EmployeeID] [int] NULL,
[OrderDate] [datetime] NULL,
[RequiredDate] [datetime] NULL,
[ShippedDate] [datetime] NULL,
[ShipVia] [int] NULL,
[Freight] [money] NULL CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)),
[ShipName] [nvarchar] (40) NULL,
[ShipAddress] [nvarchar] (60) NULL,
[ShipCity] [nvarchar] (15) NULL,
[ShipRegion] [nvarchar] (15) NULL,
[ShipPostalCode] [nvarchar] (10) NULL,
[ShipCountry] [nvarchar] (15) NULL,
[ShipCountryCode] [int] NULL
)
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID])
GO
CREATE NONCLUSTERED INDEX [CustomerID] ON [Sales].[Orders] ([CustomerID])
GO
CREATE NONCLUSTERED INDEX [CustomersOrders] ON [Sales].[Orders] ([CustomerID])
GO
CREATE NONCLUSTERED INDEX [EmployeeID] ON [Sales].[Orders] ([EmployeeID])
GO
CREATE NONCLUSTERED INDEX [EmployeesOrders] ON [Sales].[Orders] ([EmployeeID])
GO
CREATE NONCLUSTERED INDEX [OrderDate] ON [Sales].[Orders] ([OrderDate])
GO
CREATE NONCLUSTERED INDEX [ShippedDate] ON [Sales].[Orders] ([ShippedDate])
GO
CREATE NONCLUSTERED INDEX [ShipPostalCode] ON [Sales].[Orders] ([ShipPostalCode])
GO
CREATE NONCLUSTERED INDEX [ShippersOrders] ON [Sales].[Orders] ([ShipVia])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [Operation].[Employees] ([EmployeeID])
GO
ALTER TABLE [Sales].[Orders] ADD CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY ([ShipVia]) REFERENCES [Logistics].[Shippers] ([ShipperID])
GO
ALTER TABLE [Sales].[Orders] NOCHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [Sales].[Orders] NOCHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [Sales].[Orders] NOCHECK CONSTRAINT [FK_Orders_Shippers]
GO
