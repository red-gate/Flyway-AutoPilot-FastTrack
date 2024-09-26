CREATE TABLE [dbo].[WidgetPrices]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[WidgetID] [int] NULL,
[Price] [money] NULL
)
GO
ALTER TABLE [dbo].[WidgetPrices] ADD CONSTRAINT [PK_WidgetPrices] PRIMARY KEY NONCLUSTERED ([RecordID])
GO
