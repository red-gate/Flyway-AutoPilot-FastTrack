SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [dbo].[GetAllWidgets]
AS
BEGIN
	SELECT w.RecordID,
           w.Description,
		   wp.Price
	FROM Widgets w INNER JOIN dbo.WidgetPrices wp ON wp.RecordID = w.RecordID
END
GO
