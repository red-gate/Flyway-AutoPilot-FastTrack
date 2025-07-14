SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [Sales].[Order Details]'
GO
ALTER TABLE [Sales].[Order Details] DROP CONSTRAINT [FK_Order_Details_Products]
GO
PRINT N'Dropping foreign keys from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [FK_Products_Categories]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [CK_Products_UnitPrice]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [CK_UnitsInStock]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [CK_UnitsOnOrder]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [CK_ReorderLevel]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [PK_Products]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [DF_Products_UnitPrice]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [DF_Products_UnitsInStock]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [DF_Products_UnitsOnOrder]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [DF_Products_ReorderLevel]
GO
PRINT N'Dropping constraints from [Operation].[Products]'
GO
ALTER TABLE [Operation].[Products] DROP CONSTRAINT [DF_Products_Discontinued]
GO
PRINT N'Dropping index [ProductName] from [Operation].[Products]'
GO
DROP INDEX [ProductName] ON [Operation].[Products]
GO
PRINT N'Dropping index [SupplierID] from [Operation].[Products]'
GO
DROP INDEX [SupplierID] ON [Operation].[Products]
GO
PRINT N'Dropping index [SuppliersProducts] from [Operation].[Products]'
GO
DROP INDEX [SuppliersProducts] ON [Operation].[Products]
GO
PRINT N'Dropping index [CategoriesProducts] from [Operation].[Products]'
GO
DROP INDEX [CategoriesProducts] ON [Operation].[Products]
GO
PRINT N'Dropping index [CategoryID] from [Operation].[Products]'
GO
DROP INDEX [CategoryID] ON [Operation].[Products]
GO
PRINT N'Dropping [dbo].[viccy]'
GO
DROP TABLE [dbo].[viccy]
GO
PRINT N'Dropping [dbo].[ryan]'
GO
DROP TABLE [dbo].[ryan]
GO
PRINT N'Dropping [dbo].[quickTest]'
GO
DROP TABLE [dbo].[quickTest]
GO
PRINT N'Dropping [dbo].[peterlaws]'
GO
DROP TABLE [dbo].[peterlaws]
GO
PRINT N'Dropping [dbo].[newTable]'
GO
DROP TABLE [dbo].[newTable]
GO
PRINT N'Dropping [dbo].[imogen]'
GO
DROP TABLE [dbo].[imogen]
GO
PRINT N'Dropping [dbo].[elijah3]'
GO
DROP TABLE [dbo].[elijah3]
GO
PRINT N'Dropping [dbo].[alexYates]'
GO
DROP TABLE [dbo].[alexYates]
GO
PRINT N'Dropping [Operation].[Products]'
GO
DROP TABLE [Operation].[Products]
GO
PRINT N'Altering [dbo].[PlugNPlay]'
GO
ALTER TABLE [dbo].[PlugNPlay] DROP
COLUMN [Twitter]
GO

