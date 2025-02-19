SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [Customers].[Customer]'
GO
ALTER TABLE [Customers].[Customer] ADD
[CustomerUserID] [int] NULL
GO
PRINT N'Creating [dbo].[AddressBook]'
GO
CREATE TABLE [dbo].[AddressBook]
(
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[TwitterID] [int] NULL
)
GO
PRINT N'Creating [dbo].[huxSP]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[huxSP]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM AddressBook
END
GO
PRINT N'Refreshing [Customers].[CustomerFeedbackSummary]'
GO
EXEC sp_refreshview N'[Customers].[CustomerFeedbackSummary]'
GO
PRINT N'Refreshing [Sales].[CustomerOrdersView]'
GO
EXEC sp_refreshview N'[Sales].[CustomerOrdersView]'
GO

