SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping [Customers].[Offers]'
GO
DROP TABLE [Customers].[Offers]
GO
PRINT N'Altering [Customers].[Customer]'
GO
ALTER TABLE [Customers].[Customer] DROP
COLUMN [WorkPhone]
GO
PRINT N'Refreshing [Sales].[CustomerOrdersView]'
GO
EXEC sp_refreshview N'[Sales].[CustomerOrdersView]'
GO
PRINT N'Refreshing [Customers].[CustomerFeedbackSummary]'
GO
EXEC sp_refreshview N'[Customers].[CustomerFeedbackSummary]'
GO

