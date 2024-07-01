SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[WidgetPrices]'
GO
CREATE TABLE [dbo].[WidgetPrices]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[WidgetID] [int] NULL,
[Price] DECIMAL(19, 4) NULL
)
GO
PRINT N'Creating primary key [PK_WidgetPrices] on [dbo].[WidgetPrices]'
GO
ALTER TABLE [dbo].[WidgetPrices] ADD CONSTRAINT [PK_WidgetPrices] PRIMARY KEY NONCLUSTERED ([RecordID])
GO
PRINT N'Creating [dbo].[WidgetReferences]'
GO
CREATE TABLE [dbo].[WidgetReferences]
(
[WidgetID] [int] NOT NULL IDENTITY(1, 1),
[Reference] [varchar] (50) NULL
)
GO
PRINT N'Creating primary key [PK_WidgetReferences] on [dbo].[WidgetReferences]'
GO
ALTER TABLE [dbo].[WidgetReferences] ADD CONSTRAINT [PK_WidgetReferences] PRIMARY KEY NONCLUSTERED ([WidgetID])
GO
PRINT N'Creating [dbo].[Widgets]'
GO
CREATE TABLE [dbo].[Widgets]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[Description] [varchar] (50) NULL
)
GO
PRINT N'Creating primary key [PK_Widgets] on [dbo].[Widgets]'
GO
ALTER TABLE [dbo].[Widgets] ADD CONSTRAINT [PK_Widgets] PRIMARY KEY NONCLUSTERED ([RecordID])
GO

