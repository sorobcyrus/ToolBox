/***************************************************************************************************
File: CorrelatedSubQuery.sql
----------------------------------------------------------------------------------------------------
Create Date:    2021-01-01 
Author:         Sorob Cyrus
Description:    How to define a CorrelatedSubQuery
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

SELECT ColumnName,
	(SELECT MAX(Amount)
	FROM SchemaName.SecondTableName AS snd
	WHERE snd.ColumnID = fst.ColumnID 
	) AS MaxAmount
FROM SchemaName.FirstTableName AS fst;
