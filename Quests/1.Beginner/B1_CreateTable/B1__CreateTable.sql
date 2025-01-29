CREATE TABLE Sales.Promotions (
    PromotionID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    DiscountPercentage DECIMAL(4,2)
);
