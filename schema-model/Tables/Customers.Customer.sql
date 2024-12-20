CREATE TABLE [Customers].[Customer]
(
[CustomerID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) NOT NULL,
[LastName] [nvarchar] (50) NOT NULL,
[Email] [nvarchar] (100) NOT NULL,
[DateOfBirth] [date] NULL,
[Phone] [nvarchar] (20) NULL,
[Address] [nvarchar] (200) NULL
)
GO
ALTER TABLE [Customers].[Customer] ADD PRIMARY KEY CLUSTERED ([CustomerID])
GO
ALTER TABLE [Customers].[Customer] ADD UNIQUE NONCLUSTERED ([Email])
GO
