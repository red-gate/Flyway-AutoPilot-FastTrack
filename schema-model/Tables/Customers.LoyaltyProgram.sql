CREATE TABLE [Customers].[LoyaltyProgram]
(
[ProgramID] [int] NOT NULL IDENTITY(1, 1),
[ProgramName] [nvarchar] (50) NOT NULL,
[PointsMultiplier] [decimal] (3, 2) NULL DEFAULT ((1.0))
)
GO
ALTER TABLE [Customers].[LoyaltyProgram] ADD PRIMARY KEY CLUSTERED ([ProgramID])
GO
