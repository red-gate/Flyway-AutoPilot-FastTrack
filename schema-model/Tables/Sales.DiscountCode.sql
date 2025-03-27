CREATE TABLE [Sales].[DiscountCode]
(
[DiscountID] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (20) NOT NULL,
[DiscountPercentage] [decimal] (4, 2) NULL,
[ExpiryDate] [datetime] NULL
)
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [CK__DiscountC__Disco__36B12243] CHECK (([DiscountPercentage]>=(0) AND [DiscountPercentage]<=(100)))
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [PK__Discount__E43F6DF6CA2BF14E] PRIMARY KEY CLUSTERED ([DiscountID])
GO
ALTER TABLE [Sales].[DiscountCode] ADD CONSTRAINT [UQ__Discount__A25C5AA70A86FB88] UNIQUE NONCLUSTERED ([Code])
GO
