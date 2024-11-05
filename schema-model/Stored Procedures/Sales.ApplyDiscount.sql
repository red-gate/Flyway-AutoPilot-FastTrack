SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Sales].[ApplyDiscount]
    @OrderID INT,
    @DiscountCode NVARCHAR(20)
AS
BEGIN
    DECLARE @DiscountID INT, @DiscountPercentage DECIMAL(4, 2), @ExpiryDate DATETIME;
    
    SELECT 
        @DiscountID = DiscountID,
        @DiscountPercentage = DiscountPercentage,
        @ExpiryDate = ExpiryDate
    FROM Sales.DiscountCode
    WHERE Code = @DiscountCode;
    
    IF @DiscountID IS NOT NULL AND @ExpiryDate >= GETDATE()
    BEGIN
        UPDATE Sales.Orders
        SET TotalAmount = TotalAmount * (1 - @DiscountPercentage / 100)
        WHERE OrderID = @OrderID;

        INSERT INTO Sales.OrderAuditLog (OrderID, ChangeDescription)
        VALUES (@OrderID, CONCAT('Discount ', @DiscountCode, ' applied with ', @DiscountPercentage, '% off.'));
    END
    ELSE
    BEGIN
        RAISERROR('Invalid or expired discount code.', 16, 1);
    END
END;
GO
