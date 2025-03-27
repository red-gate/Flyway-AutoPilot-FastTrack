CREATE TABLE [Logistics].[EmployeeTerritories]
(
[EmployeeID] [int] NOT NULL,
[TerritoryID] [nvarchar] (20) NOT NULL
)
GO
ALTER TABLE [Logistics].[EmployeeTerritories] ADD CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID], [TerritoryID])
GO
ALTER TABLE [Logistics].[EmployeeTerritories] ADD CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [Operation].[Employees] ([EmployeeID])
GO
ALTER TABLE [Logistics].[EmployeeTerritories] ADD CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[Territories] ([TerritoryID])
GO
ALTER TABLE [Logistics].[EmployeeTerritories] NOCHECK CONSTRAINT [FK_EmployeeTerritories_Employees]
GO
ALTER TABLE [Logistics].[EmployeeTerritories] NOCHECK CONSTRAINT [FK_EmployeeTerritories_Territories]
GO
