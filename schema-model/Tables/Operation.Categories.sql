CREATE TABLE [Operation].[Categories]
(
[CategoryID] [int] NOT NULL IDENTITY(1, 1),
[CategoryName] [nvarchar] (15) NOT NULL,
[Description] [ntext] NULL,
[Picture] [image] NULL,
[date] [date] NULL
)
GO
ALTER TABLE [Operation].[Categories] ADD CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID])
GO
CREATE NONCLUSTERED INDEX [CategoryName] ON [Operation].[Categories] ([CategoryName])
GO
