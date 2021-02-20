/***************************************************************************************************
File: Inlineable.sql
----------------------------------------------------------------------------------------------------
Create Date:    2021-01-01 
Author:         Sorob Cyrus
Description:    List of Dependent objects 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

SELECT dm_sql_referencing_entities.referencing_schema_name,
    dm_sql_referencing_entities.referencing_entity_name,
    sql_modules.object_id,
    sql_modules.definition,
    sql_modules.is_schema_bound
FROM 
    sys.dm_sql_referencing_entities ('SchemaName.Table', 'OBJECT')
JOIN 
    sys.sql_modules 
ON 
    dm_sql_referencing_entities.referencing_id = sql_modules.object_id;