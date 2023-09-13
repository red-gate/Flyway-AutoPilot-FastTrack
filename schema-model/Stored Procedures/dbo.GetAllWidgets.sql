SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [dbo].[GetAllWidgets]
AS
BEGIN
	SELECT w.RecordID,
           w.Description,
		   p.Price
	FROM Widgets w INNER JOIN dbo.WidgetPrices p ON p.RecordID = w.RecordID
END
GO
