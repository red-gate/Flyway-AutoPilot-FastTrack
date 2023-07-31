CREATE TABLE [dbo].[WidgetReferences]
(
[WidgetID] [int] NOT NULL IDENTITY(1, 1),
[Reference] [varchar] (50) NULL
)
GO
ALTER TABLE [dbo].[WidgetReferences] ADD CONSTRAINT [PK_WidgetReferences] PRIMARY KEY NONCLUSTERED ([WidgetID])
GO
