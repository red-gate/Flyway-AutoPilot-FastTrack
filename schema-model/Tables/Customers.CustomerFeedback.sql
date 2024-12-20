CREATE TABLE [Customers].[CustomerFeedback]
(
[FeedbackID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[FeedbackDate] [datetime] NULL DEFAULT (getdate()),
[Rating] [int] NULL,
[Comments] [nvarchar] (500) NULL
)
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD PRIMARY KEY CLUSTERED ([FeedbackID])
GO
ALTER TABLE [Customers].[CustomerFeedback] ADD FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO
