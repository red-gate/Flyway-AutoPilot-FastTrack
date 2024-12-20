CREATE TABLE [Sales].[OrderAuditLog]
(
[AuditID] [int] NOT NULL IDENTITY(1, 1),
[OrderID] [int] NULL,
[ChangeDate] [datetime] NULL DEFAULT (getdate()),
[ChangeDescription] [nvarchar] (500) NULL
)
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD PRIMARY KEY CLUSTERED ([AuditID])
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD FOREIGN KEY ([OrderID]) REFERENCES [Sales].[Orders] ([OrderID])
GO
