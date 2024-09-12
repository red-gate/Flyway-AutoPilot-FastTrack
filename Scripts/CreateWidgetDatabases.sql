USE tempdb;
GO

/* ********************
Set up a temporary table with the names of the databases to be created **'
******************** */
/* Drop the table if it already exists */
BEGIN TRY
  DROP TABLE ##DatabaseNames
END TRY
BEGIN CATCH
  PRINT '##DatabaseNames not available to drop'
END CATCH

/* Create a table variable to hold all the database names in our pipeline */
CREATE TABLE ##DatabaseNames
(
    ID INT IDENTITY(1, 1),
    Name NVARCHAR(100)
);

/* Insert the databae names to be created.  
   For a Proof of Concept (POC), you'll want at least Dev, Test, Prod.	*/
INSERT INTO ##DatabaseNames 
(
    Name
)
VALUES
('WidgetDev'),			-- The "WidgetDev" database must exist; we use it below for some initial objects for the POC workflow
('WidgetTest'),
('WidgetStaging'),
('WidgetProd');
GO

/* ******************** */
PRINT '** Checking names of the databases to be created **'
/* ******************** */
SELECT * FROM ##DatabaseNames;
GO


/* Do not edit below this line */
CREATE OR ALTER PROCEDURE CreateDatabase @dbName AS NVARCHAR(100)
AS
BEGIN
	/* ******************** */
	PRINT '** Creating database: ' + @dbName + ' **'
	/* ******************** */
    DECLARE @procSqlString NVARCHAR(200);
    SET @procSqlString = N'';

	IF EXISTS (SELECT name FROM sys.databases WHERE name = @dbName)
    BEGIN
		SET @procSqlString = N'DROP DATABASE ' + @dbName + N';';
		EXECUTE sys.sp_executesql @procSqlString;
	END

	SET @procSqlString = N'CREATE DATABASE ' + @dbName + N';';
	EXECUTE sys.sp_executesql @procSqlString;
END
GO

CREATE OR ALTER PROCEDURE CreateSchema @dbName AS NVARCHAR(100)
AS
BEGIN
	/* ******************** */
	PRINT '** Creating schema in database: ' + @dbName + ' **'
	/* ******************** */
	DECLARE @procSqlString NVARCHAR(500);

	SET @procSqlString = 'CREATE TABLE ' +@dbName + '.[dbo].[WidgetPrices] (' +
	'	[RecordID] [int] IDENTITY (1, 1) NOT NULL ,' +
	'	[WidgetID] [int] NULL ,' +
	'	[Price] [money] NULL ' +
	') ON [PRIMARY]'
	EXECUTE sys.sp_executesql @procSqlString;


	SET @procSqlString = 'CREATE TABLE ' +@dbName + '.[dbo].[Widgets] (' +
	'	[RecordID] [int] IDENTITY (1, 1) NOT NULL ,' +
	'	[Description] [varchar] (50) NULL' + 
	') ON [PRIMARY]'
	EXECUTE sys.sp_executesql @procSqlString;

	/* Insert some data into the Widgets table */
	PRINT 'Inserting data into Widgets on database: ' + @dbName
	SET @procSqlString = 'INSERT INTO ' +@dbName + '.[dbo].[Widgets] (DESCRIPTION) '+
	'VALUES ' +
	'(''Widget1''), ' + 
	'(''Widget2''), ' + 
	'(''Widget3'');' 
	EXECUTE sys.sp_executesql @procSqlString;

	SET @procSqlString = 'CREATE TABLE ' +@dbName + '.[dbo].[WidgetReferences] (' +
	'	[WidgetID] [int] IDENTITY NOT NULL ,' +
	'	[Reference] [varchar] (50) NULL ' +
	') ON [PRIMARY]'
	EXECUTE sys.sp_executesql @procSqlString;

	SET @procSqlString = 'ALTER TABLE ' +@dbName + '.[dbo].[WidgetReferences] WITH NOCHECK ADD ' + 
		'CONSTRAINT [PK_WidgetReferences] PRIMARY KEY  NONCLUSTERED ' +
		'(' +
		'	[WidgetID]' +
		')  ON [PRIMARY] '
	EXECUTE sys.sp_executesql @procSqlString;

	SET @procSqlString = 'ALTER TABLE ' +@dbName + '.[dbo].[WidgetPrices] WITH NOCHECK ADD ' +
		'CONSTRAINT [PK_WidgetPrices] PRIMARY KEY  NONCLUSTERED ' +
		'(' +
		'	[RecordID]' +
		')  ON [PRIMARY] '
	EXECUTE sys.sp_executesql @procSqlString;

	SET @procSqlString = 'ALTER TABLE ' +@dbName + '.[dbo].[Widgets] WITH NOCHECK ADD ' +
		'CONSTRAINT [PK_Widgets] PRIMARY KEY  NONCLUSTERED ' +
		'(' +
		'	[RecordID]' +
		')  ON [PRIMARY] '
	EXECUTE sys.sp_executesql @procSqlString;

/*
	/* NOT ALLOWED TO SPECIFY 3 PART NAME WHEN CREATING VIEWS */
	SET @procSqlString = N'CREATE VIEW ' + @dbName + '.dbo.CurrentPrices ' +
	'AS ' +
	'SELECT WidgetID, Price, Description ' +
	'FROM Widgets INNER JOIN ' +
	'	WidgetPrices ON Widgets.RecordID = WidgetPrices.WidgetID '
	EXEC sys.sp_executesql @procSqlString
*/
END
GO

/* 
Loop through all the database names in the temp DatabaseNames table created and populated above 
For each database, switch to that database and then create all the objects in that database 
as defined by the createDatabase stored procedure
*/

DECLARE @minID INT;
DECLARE @maxID INT;

SELECT @minID = MIN(ID),
       @maxID = MAX(ID)
FROM ##DatabaseNames;

DECLARE @databaseName NVARCHAR(100);
SET @databaseName = N'';

DECLARE @sqlString NVARCHAR(200);
SET @sqlString = N'';

WHILE @minID <= @maxID
BEGIN
	SELECT @databaseName = Name
    FROM ##DatabaseNames
    WHERE ID = @minID;

    SELECT @minID = @minID + 1;

    EXEC CreateDatabase @databaseName;
	
	SET @sqlString = N'USE ' + @databaseName + N';';

	EXEC sys.sp_executesql @sqlString;

	/* Create the schema objects in the database */
    EXEC CreateSchema @databaseName;
	
END;

USE tempdb;
GO

/* Create empty databases needed for the workflow */
BEGIN TRY
	CREATE DATABASE WidgetZShadow;
END TRY
BEGIN CATCH
  PRINT 'WidgetZShadow must already exist';
END CATCH

BEGIN TRY
  CREATE DATABASE WidgetZBuild;
END TRY
BEGIN CATCH
  PRINT 'WidgetZBuild must already exist';
END CATCH

BEGIN TRY
  CREATE DATABASE WidgetZCheck;
END TRY
BEGIN CATCH
  PRINT 'WidgetZCheck must already exist';
END CATCH

DROP PROC dbo.CreateDatabase;
GO
DROP PROC dbo.CreateSchema;
GO



/* ******************************* */
PRINT '** Adding some extra objects to WidgetDev **'
/* ******************************* */
USE WidgetDev;
GO

CREATE OR ALTER VIEW dbo.CurrentPrices
	AS
	SELECT WidgetID, Price, Description
	FROM Widgets INNER JOIN
		WidgetPrices ON Widgets.RecordID = WidgetPrices.WidgetID
GO

CREATE OR ALTER PROCEDURE dbo.GetAllWidgets
AS
BEGIN
	SELECT RecordID,
           Description 
	FROM Widgets
END
GO
	
USE WidgetDev;
GO

IF OBJECT_ID('dbo.CurrentPrices', 'V') IS NULL
BEGIN
    EXEC ('CREATE VIEW dbo.CurrentPrices
    AS
    SELECT WidgetID, Price, Description
    FROM dbo.Widgets
    JOIN dbo.WidgetPrices ON dbo.Widgets.RecordID = dbo.WidgetPrices.WidgetID;');
END
GO

IF OBJECT_ID('dbo.GetAllWidgets', 'P') IS NULL
BEGIN
    EXEC ('CREATE PROCEDURE dbo.GetAllWidgets
    AS
    BEGIN
        SELECT RecordID, Description
        FROM dbo.Widgets;
    END');
END
GO


/* Test data exists in Widget table on dev */
/*
Use WidgetDev;
GO

EXEC dbo.GetAllWidgets;
*/
