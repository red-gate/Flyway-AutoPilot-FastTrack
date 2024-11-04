SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Sales].[UpdateOrderStatus]
    @OrderID INT,
    @NewStatus NVARCHAR(20)
AS
BEGIN
    UPDATE Sales.Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;
END;
GO
