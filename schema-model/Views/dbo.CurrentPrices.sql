SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   VIEW [dbo].[CurrentPrices]
	AS
	SELECT WidgetID, Price, Description
	FROM Widgets INNER JOIN
		WidgetPrices ON Widgets.RecordID = WidgetPrices.WidgetID
GO
