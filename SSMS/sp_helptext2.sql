use master;
go
/* 
	Created By: Timothy Corey
	Date: June 27, 2014
	Purpose: Identify information about the given text
	Inputs:
		@objname: The name (or partial name) to look up
	Notes: This proc upgrades the sp_helptext system proc by adding a search if no
		   exact match is found for an item. The search returns the items that have
		   the given text in their name (stored procs, tables and views). If the
		   searched-on item is a table then the table's columns, constraints and
		   indexes are returned.
*/
CREATE procedure [dbo].[sp_helptext2]
	@objname nvarchar(776)
as

set nocount on

declare @dbname sysname
,@objid	int
,@BlankSpaceAdded   int
,@BasePos       int
,@CurrentPos    int
,@TextLength    int
,@LineId        int
,@AddOnLen      int
,@LFCR          int --lengths of line feed carriage return
,@DefinedLength int

/* NOTE: Length of @SyscomText is 4000 to replace the length of
** text column in syscomments.
** lengths on @Line, #CommentText Text column and
** value for @DefinedLength are all 255. These need to all have
** the same values. 255 was selected in order for the max length
** display using down level clients
*/
,@SyscomText	nvarchar(4000)
,@Line          nvarchar(255)
,@FullName varchar(200)
,@SchemaName varchar(200)
,@ItemName varchar(200)

select @DefinedLength = 255
select @BlankSpaceAdded = 0 /*Keeps track of blank spaces at end of lines. Note Len function ignores
                             trailing blank spaces*/
CREATE TABLE #CommentText
(LineId	int
 ,Text  nvarchar(255))

/*
**  Make sure the @objname is local to the current database.
*/
select @dbname = parsename(@objname,3)
if @dbname is null
	select @dbname = db_name()
else if @dbname <> db_name()
        begin
                raiserror(15250,-1,-1)
                return (1)
        end

--Sets up the schema name variable and the table/view/sproc name variable
select @SchemaName = parsename(@objname,2), @ItemName = parsename(@objname, 1)
if @SchemaName is null
	select @SchemaName = SCHEMA_NAME()

/*
**  See if @objname exists.
*/
select @objid = object_id(@objname)
if (@objid is null)
        begin
			-- Instead, return all of the tables, views and stored procedures that match that name
			EXECUTE('
			select TABLE_SCHEMA as SchemaName, TABLE_NAME as ItemName, TABLE_TYPE as ItemType, TABLE_SCHEMA + ''.'' + TABLE_NAME as FullName 
			from ' + @dbname + '.information_schema.tables where table_name like ''%' + @objname + '%''
			union all
			select ROUTINE_SCHEMA, ROUTINE_NAME, ''Stored Procedure'',  ROUTINE_SCHEMA + ''.'' + ROUTINE_NAME
			from ' + @dbname + '.INFORMATION_SCHEMA.ROUTINES
			where ROUTINE_TYPE=''PROCEDURE'' and routine_name like ''%' + @objname + '%''')
			return(0)
        end

if @objid < 0	-- Handle system-objects
	begin
		-- Check count of rows with text data
		if (select count(*) from master.sys.syscomments where id = @objid and text is not null) = 0
			begin
				--Return Table information
				--Table Columns
				execute('SELECT COLUMN_NAME as ColumnName, ORDINAL_POSITION as Position, COLUMN_DEFAULT as DefaultValue, 
					IS_NULLABLE as Nullable, case when CHARACTER_MAXIMUM_LENGTH is null then 
					DATA_TYPE else DATA_TYPE + ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(10)) + '')'' 
					end as DataType
					FROM ' + @dbname + '.INFORMATION_SCHEMA.COLUMNS
					WHERE TABLE_NAME = ''' + @ItemName + ''' and TABLE_CATALOG = ''' + @dbname + 
					''' and TABLE_SCHEMA = ''' + @SchemaName + '''')

				--Table Constraints
				execute('SELECT CONSTRAINT_NAME as ConstraintName
					FROM ' + @dbname + '.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
					WHERE TABLE_NAME = ''' + @ItemName + ''' and TABLE_CATALOG = ''' + @dbname + 
					''' and TABLE_SCHEMA = ''' + @SchemaName + '''')

				--Table Indexes
				execute('SELECT name as IndexName, type_desc as IndexType, is_unique as IsUnique, is_primary_key as PrimaryKey
					FROM ' + @dbname + '.sys.indexes
					WHERE [object_id] = OBJECT_ID(''' + @objname + ''')')
				return(0)
			end
			
		declare ms_crs_syscom CURSOR LOCAL FOR select text from master.sys.syscomments where id = @objid
			ORDER BY number, colid FOR READ ONLY
	end
else
    begin
        /*
        **  Find out how many lines of text are coming back,
        **  and return if there are none.
        */
        if (select count(*) from syscomments c, sysobjects o where o.xtype not in ('S', 'U')
            and o.id = c.id and o.id = @objid) = 0
                begin
					--Return Table information
					--Table Columns
					execute('SELECT COLUMN_NAME as ColumnName, ORDINAL_POSITION as Position, COLUMN_DEFAULT as DefaultValue, 
						IS_NULLABLE as Nullable, case when CHARACTER_MAXIMUM_LENGTH is null then 
						DATA_TYPE else DATA_TYPE + ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(10)) + '')'' 
						end as DataType
						FROM ' + @dbname + '.INFORMATION_SCHEMA.COLUMNS
						WHERE TABLE_NAME = ''' + @ItemName + ''' and TABLE_CATALOG = ''' + @dbname + 
						''' and TABLE_SCHEMA = ''' + @SchemaName + '''')

					--Table Constraints
					execute('SELECT CONSTRAINT_NAME as ConstraintName
						FROM ' + @dbname + '.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
						WHERE TABLE_NAME = ''' + @ItemName + ''' and TABLE_CATALOG = ''' + @dbname + 
						''' and TABLE_SCHEMA = ''' + @SchemaName + '''')

					--Table Indexes
					execute('SELECT name as IndexName, type_desc as IndexType, is_unique as IsUnique, is_primary_key as PrimaryKey
						FROM ' + @dbname + '.sys.indexes
						WHERE [object_id] = OBJECT_ID(''' + @objname + ''')')
					return(0)
                end

        if (select count(*) from syscomments where id = @objid and encrypted = 0) = 0
                begin
                        raiserror(15471,-1,-1,@objname)
                        return (0)
                end

		declare ms_crs_syscom  CURSOR LOCAL
		FOR select text from syscomments where id = @objid and encrypted = 0
				ORDER BY number, colid
		FOR READ ONLY

    end

/*
**  else get the text.
*/
select @LFCR = 2
select @LineId = 1


OPEN ms_crs_syscom

FETCH NEXT from ms_crs_syscom into @SyscomText

WHILE @@fetch_status >= 0
begin

    select  @BasePos    = 1
    select  @CurrentPos = 1
    select  @TextLength = LEN(@SyscomText)

    WHILE @CurrentPos  != 0
    begin
        --Looking for end of line followed by carriage return
        select @CurrentPos = CHARINDEX(char(13)+char(10), @SyscomText, @BasePos)

        --If carriage return found
        IF @CurrentPos != 0
        begin
            /*If new value for @Lines length will be > then the
            **set length then insert current contents of @line
            **and proceed.
            */
            while (isnull(LEN(@Line),0) + @BlankSpaceAdded + @CurrentPos-@BasePos + @LFCR) > @DefinedLength
            begin
                select @AddOnLen = @DefinedLength-(isnull(LEN(@Line),0) + @BlankSpaceAdded)
                INSERT #CommentText VALUES
                ( @LineId,
                  --Fixes Line Break issue
				  --isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))
				  isnull(REPLACE(REPLACE(ISNULL( @Line, ''), CHAR(13), ''), CHAR(10), ''), N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))
                select @Line = NULL, @LineId = @LineId + 1,
                       @BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
            end
            select @Line    = isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @CurrentPos-@BasePos + @LFCR), N'')
            select @BasePos = @CurrentPos+2
			--Fixes Line Break issue
            --INSERT #CommentText VALUES( @LineId, @Line )
            INSERT #CommentText VALUES( @LineId, REPLACE(REPLACE(ISNULL( @Line, ''), CHAR(13), ''), CHAR(10), '') )
            select @LineId = @LineId + 1
            select @Line = NULL
        end
        else
        --else carriage return not found
        begin
            IF @BasePos <= @TextLength
            begin
                /*If new value for @Lines length will be > then the
                **defined length
                */
                while (isnull(LEN(@Line),0) + @BlankSpaceAdded + @TextLength-@BasePos+1 ) > @DefinedLength
                begin
                    select @AddOnLen = @DefinedLength - (isnull(LEN(@Line),0) + @BlankSpaceAdded)
                    INSERT #CommentText VALUES
                    ( @LineId,
					--Fixes Line Break issue
                    --isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))
					isnull(REPLACE(REPLACE(ISNULL( @Line, ''), CHAR(13), ''), CHAR(10), ''), N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))
                    select @Line = NULL, @LineId = @LineId + 1,
                        @BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
                end
                select @Line = isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @TextLength-@BasePos+1 ), N'')
                if LEN(@Line) < @DefinedLength and charindex(' ', @SyscomText, @TextLength+1 ) > 0
                begin
                    select @Line = @Line + ' ', @BlankSpaceAdded = 1
                end
            end
        end
    end

	FETCH NEXT from ms_crs_syscom into @SyscomText
end

IF @Line is NOT NULL
    INSERT #CommentText VALUES( @LineId, @Line )

select Text from #CommentText order by LineId

CLOSE  ms_crs_syscom
DEALLOCATE 	ms_crs_syscom

DROP TABLE 	#CommentText

return (0)