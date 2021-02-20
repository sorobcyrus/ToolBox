/***************************************************************************************************
File: CreateFKs.sql
----------------------------------------------------------------------------------------------------
Create Date:    2021-01-01 
Author:         Sorob Cyrus
Description:    How to define a FK relationship
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText VARCHAR(MAX),      
        @Message   VARCHAR(255)

SET @ErrorText = 'Failed adding FOREIGN KEY for Table SchemaName.FKTableName.';

IF EXISTS (SELECT *
	FROM sys.foreign_keys
	WHERE object_id = OBJECT_ID(N'SchemaName.FK_FKTableName_PKTableName_FKColumnName')
	AND parent_object_id = OBJECT_ID(N'SchemaName.FKTableName')
	)
BEGIN
  SET @Message = 'FOREIGN KEY for Table SchemaName.FKTableName already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
  ALTER TABLE SchemaName.FKTableName
	ADD CONSTRAINT FK_FKTableName_PKTableName_FKColumnName FOREIGN KEY (FKColumnName)
    REFERENCES SchemaName.PKTableName (PKColumnName);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE SchemaName.FKTableName.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
END