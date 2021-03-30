--Find FKs for a table
EXEC sp_fkeys @pktable_name = 'TblName', @pktable_owner = 'SchemaName'

--This field name is misleading.. It should've been named 
--relationship_owner_object_id (instead of parent_object_id)
SELECT parent_object_id
    FROM sys.foreign_keys
    WHERE object_id = OBJECT_ID(N'Person.FK_Name')

--Add FK to an existing Table
ALTER TABLE [Schema].[FK_TblName]  WITH CHECK ADD  CONSTRAINT [FK_Name] 
								FOREIGN KEY([FKColumnID])
								REFERENCES [Schema].[PKTblName] ([PKColumnID])
