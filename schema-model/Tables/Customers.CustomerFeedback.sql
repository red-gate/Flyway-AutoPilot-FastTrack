CREATE TABLE [Customers].[CustomerFeedback]
(
[FeedbackID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[FeedbackDate] [datetime] NULL CONSTRAINT [DF__CustomerF__Feedb__2A4B4B5E] DEFAULT (getdate()),
[Rating] [int] NULL,
[Comments] [nvarchar] (500) NULL
)
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [CK__CustomerF__Ratin__2B3F6F97] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [PK__Customer__6A4BEDF63E215A69] PRIMARY KEY CLUSTERED ([FeedbackID])
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CONSTRAINT [FK__CustomerF__Custo__29572725] FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
