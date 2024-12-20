CREATE TABLE [Sales].[DiscountCode]
(
[DiscountID] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (20) NOT NULL,
[DiscountPercentage] [decimal] (4, 2) NULL,
[ExpiryDate] [datetime] NULL
)
GO
ALTER TABLE [Sales].[DiscountCode] ADD CHECK (([DiscountPercentage]>=(0) AND [DiscountPercentage]<=(100)))
GO
ALTER TABLE [Sales].[DiscountCode] ADD PRIMARY KEY CLUSTERED ([DiscountID])
GO
ALTER TABLE [Sales].[DiscountCode] ADD UNIQUE NONCLUSTERED ([Code])
GO
