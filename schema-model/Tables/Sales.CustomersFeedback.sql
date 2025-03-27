CREATE TABLE [Sales].[CustomersFeedback]
(
[FeedbackID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [nchar] (5) NULL,
[FeedbackDate] [datetime] NULL CONSTRAINT [DF__Customers__Feedb__29572725] DEFAULT (getdate()),
[Rating] [int] NULL,
[Comments] [nvarchar] (500) NULL
)
GO
ALTER TABLE [Sales].[CustomersFeedback] ADD CONSTRAINT [CK__Customers__Ratin__2A4B4B5E] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [Sales].[CustomersFeedback] ADD CONSTRAINT [PK__Customer__6A4BEDF61A949274] PRIMARY KEY CLUSTERED ([FeedbackID])
GO
ALTER TABLE [Sales].[CustomersFeedback] ADD CONSTRAINT [FK__Customers__Custo__286302EC] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID])
GO
ALTER TABLE [Sales].[CustomersFeedback] NOCHECK CONSTRAINT [FK__Customers__Custo__286302EC]
GO
