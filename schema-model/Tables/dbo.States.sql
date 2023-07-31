CREATE TABLE [dbo].[States]
(
[ID] [int] NOT NULL,
[Abbreviation] [nvarchar] (5) NOT NULL,
[Name] [nvarchar] (100) NOT NULL
)
GO
ALTER TABLE [dbo].[States] ADD CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED ([ID])
GO
