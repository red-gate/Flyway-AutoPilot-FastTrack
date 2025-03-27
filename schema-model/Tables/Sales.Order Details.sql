CREATE TABLE [Sales].[Order Details]
(
[OrderID] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[UnitPrice] [money] NOT NULL CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT ((0)),
[Quantity] [smallint] NOT NULL CONSTRAINT [DF_Order_Details_Quantity] DEFAULT ((1)),
[Discount] [real] NOT NULL CONSTRAINT [DF_Order_Details_Discount] DEFAULT ((0))
)
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [CK_Discount] CHECK (([Discount]>=(0) AND [Discount]<=(1)))
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [CK_Quantity] CHECK (([Quantity]>(0)))
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [CK_UnitPrice] CHECK (([UnitPrice]>=(0)))
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID], [ProductID])
GO
CREATE NONCLUSTERED INDEX [OrderID] ON [Sales].[Order Details] ([OrderID])
GO
CREATE NONCLUSTERED INDEX [OrdersOrder_Details] ON [Sales].[Order Details] ([OrderID])
GO
CREATE NONCLUSTERED INDEX [ProductID] ON [Sales].[Order Details] ([ProductID])
GO
CREATE NONCLUSTERED INDEX [ProductsOrder_Details] ON [Sales].[Order Details] ([ProductID])
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [Sales].[Orders] ([OrderID])
GO
ALTER TABLE [Sales].[Order Details] ADD CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [Operation].[Products] ([ProductID])
GO
ALTER TABLE [Sales].[Order Details] NOCHECK CONSTRAINT [FK_Order_Details_Orders]
GO
ALTER TABLE [Sales].[Order Details] NOCHECK CONSTRAINT [FK_Order_Details_Products]
GO
