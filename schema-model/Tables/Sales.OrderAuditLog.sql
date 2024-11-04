CREATE TABLE [Sales].[OrderAuditLog]
(
[AuditID] [int] NOT NULL IDENTITY(1, 1),
[OrderID] [int] NULL,
[ChangeDate] [datetime] NULL CONSTRAINT [DF__OrderAudi__Chang__412EB0B6] DEFAULT (getdate()),
[ChangeDescription] [nvarchar] (500) NULL
)
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD CONSTRAINT [PK__OrderAud__A17F23B8237E8CF2] PRIMARY KEY CLUSTERED ([AuditID])
GO
ALTER TABLE [Sales].[OrderAuditLog] ADD CONSTRAINT [FK__OrderAudi__Order__403A8C7D] FOREIGN KEY ([OrderID]) REFERENCES [Sales].[Orders] ([OrderID])
GO
