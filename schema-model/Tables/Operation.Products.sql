CREATE TABLE [Operation].[Products]
(
[ProductID] [int] NOT NULL IDENTITY(1, 1),
[ProductName] [nvarchar] (40) NOT NULL,
[SupplierID] [int] NULL,
[CategoryID] [int] NULL,
[QuantityPerUnit] [nvarchar] (20) NULL,
[UnitPrice] [money] NULL CONSTRAINT [DF_Products_UnitPrice] DEFAULT ((0)),
[UnitsInStock] [smallint] NULL CONSTRAINT [DF_Products_UnitsInStock] DEFAULT ((0)),
[UnitsOnOrder] [smallint] NULL CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT ((0)),
[ReorderLevel] [smallint] NULL CONSTRAINT [DF_Products_ReorderLevel] DEFAULT ((0)),
[Discontinued] [bit] NOT NULL CONSTRAINT [DF_Products_Discontinued] DEFAULT ((0)),
[Colour] [nvarchar] (50) NULL,
[Colour2] [nvarchar] (50) NULL,
[Colour3] [nvarchar] (50) NULL
)
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [CK_Products_UnitPrice] CHECK (([UnitPrice]>=(0)))
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [CK_ReorderLevel] CHECK (([ReorderLevel]>=(0)))
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [CK_UnitsInStock] CHECK (([UnitsInStock]>=(0)))
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [CK_UnitsOnOrder] CHECK (([UnitsOnOrder]>=(0)))
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID])
GO
CREATE NONCLUSTERED INDEX [CategoriesProducts] ON [Operation].[Products] ([CategoryID])
GO
CREATE NONCLUSTERED INDEX [CategoryID] ON [Operation].[Products] ([CategoryID])
GO
CREATE NONCLUSTERED INDEX [ProductName] ON [Operation].[Products] ([ProductName])
GO
CREATE NONCLUSTERED INDEX [SupplierID] ON [Operation].[Products] ([SupplierID])
GO
CREATE NONCLUSTERED INDEX [SuppliersProducts] ON [Operation].[Products] ([SupplierID])
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [Operation].[Categories] ([CategoryID])
GO
ALTER TABLE [Operation].[Products] ADD CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY ([SupplierID]) REFERENCES [Logistics].[Suppliers] ([SupplierID])
GO
ALTER TABLE [Operation].[Products] NOCHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [Operation].[Products] NOCHECK CONSTRAINT [FK_Products_Suppliers]
GO
