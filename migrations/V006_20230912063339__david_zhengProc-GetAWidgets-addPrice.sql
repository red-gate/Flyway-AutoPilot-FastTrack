SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[GetAllWidgets]'
GO

ALTER   PROCEDURE [dbo].[GetAllWidgets]
AS
BEGIN
	SELECT w.RecordID,
           w.Description,
		   wp.Price
	FROM Widgets w INNER JOIN dbo.WidgetPrices wp ON wp.RecordID = w.RecordID
END
GO

