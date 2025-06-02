-- Support for multiple schema names; drop all table constraints
--------------------------------------------------
DECLARE @name VARCHAR(100)
DECLARE @table VARCHAR(100)
DECLARE @schema VARCHAR(100)

-- Drop all table constraints: this goes through alter table
PRINT 'Dropping all table constraints...'

DECLARE c CURSOR FOR
	SELECT a.name AS [constraint], b.name AS [table], OBJECT_SCHEMA_NAME(b.id) AS [schema]
	FROM dbo.sysobjects a
	INNER JOIN dbo.sysobjects b ON a.parent_obj = b.id
	WHERE a.xtype IN ('F','D','C','UQ') AND b.xtype='U'
OPEN c
FETCH NEXT FROM c INTO @name, @table, @schema
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'Dropping constraint [' + @name + '] on table [' + @schema + '].[' + @table + ']...'
	EXEC ('ALTER TABLE [' + @schema + '].[' + @table + '] DROP CONSTRAINT [' + @name + ']')
	FETCH NEXT FROM c INTO @name, @table, @schema
END
CLOSE c
DEALLOCATE c

GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE name='TestFramework_DropAll' AND xtype='P')
BEGIN
	PRINT 'Dropping existing procedure [TestFramework_DropAll]...'
	DROP PROCEDURE TestFramework_DropAll
END

GO

CREATE PROCEDURE TestFramework_DropAll (@xtype VARCHAR(2), @drop VARCHAR(20))
AS
BEGIN
	DECLARE @name VARCHAR(100), @id BIGINT, @schema VARCHAR(100)
	DECLARE c CURSOR FOR SELECT name, id, OBJECT_SCHEMA_NAME(id) FROM dbo.sysobjects WHERE xtype=@xtype
	PRINT 'Starting to drop objects of type [' + @xtype + ']...'
	OPEN c
	FETCH NEXT FROM c INTO @name, @id, @schema
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @name != 'TestFramework_DropAll' AND @schema != 'sys'
		BEGIN
			PRINT 'Dropping [' + @drop + '] [' + @schema + '].[' + @name + ']...'
			EXEC ('DROP ' + @drop + ' [' + @schema + '].[' + @name + ']')
		END
		FETCH NEXT FROM c INTO @name, @id, @schema
	END
	CLOSE c
	DEALLOCATE c
	PRINT 'Finished dropping objects of type [' + @xtype + ']'
END

GO

-- Drop stuff in this order to avoid dependency errors
PRINT 'Dropping views...'
EXEC TestFramework_DropAll 'V', 'view'
GO
PRINT 'Dropping scalar functions...'
EXEC TestFramework_DropAll 'FN', 'function'
GO
PRINT 'Dropping inline table-valued functions...'
EXEC TestFramework_DropAll 'IF', 'function'
GO
PRINT 'Dropping multi-statement table-valued functions...'
EXEC TestFramework_DropAll 'TF', 'function'
GO
PRINT 'Dropping tables...'
EXEC TestFramework_DropAll 'U', 'table'
GO
PRINT 'Dropping procedures...'
EXEC TestFramework_DropAll 'P', 'procedure'
GO

-- User-defined types are a special case as they are not listed in sysobjects
PRINT 'Dropping user-defined types...'
DECLARE c CURSOR FOR
	SELECT name FROM sys.types WHERE is_user_defined=1
DECLARE @name VARCHAR(100)
OPEN c
FETCH NEXT FROM c INTO @name
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'Dropping type [' + @name + ']...'
	EXEC ('DROP TYPE [' + @name + ']')
	FETCH NEXT FROM c INTO @name
END
CLOSE c
DEALLOCATE c

GO

-- Drop schemas except for standard/built-in ones
PRINT 'Dropping non-standard schemas...'
DECLARE c CURSOR FOR
	SELECT name FROM sys.schemas WHERE name NOT IN ('dbo','guest','INFORMATION_SCHEMA','sys')
DECLARE @name VARCHAR(100)
OPEN c
FETCH NEXT FROM c INTO @name
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'Dropping schema [' + @name + ']...'
	EXEC ('DROP SCHEMA [' + @name + ']')
	FETCH NEXT FROM c INTO @name
END
CLOSE c
DEALLOCATE c

GO

PRINT 'Dropping defaults...'
EXEC TestFramework_DropAll 'D', 'default'
GO

PRINT 'Dropping procedure [TestFramework_DropAll]...'
DROP PROCEDURE TestFramework_DropAll

GO

PRINT 'All non-standard objects and schemas have been dropped.'
