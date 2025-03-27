CREATE TABLE [Sales].[LoyaltyProgram]
(
[ProgramID] [int] NOT NULL IDENTITY(1, 1),
[ProgramName] [nvarchar] (50) NOT NULL,
[PointsMultiplier] [decimal] (3, 2) NULL CONSTRAINT [DF__LoyaltyPr__Point__239E4DCF] DEFAULT ((1.0))
)
GO
ALTER TABLE [Sales].[LoyaltyProgram] ADD CONSTRAINT [PK__LoyaltyP__7525603848DEBC46] PRIMARY KEY CLUSTERED ([ProgramID])
GO
