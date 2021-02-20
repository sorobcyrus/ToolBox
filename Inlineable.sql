/***************************************************************************************************
File: Inlineable.sql
----------------------------------------------------------------------------------------------------
Create Date:    2021-01-01 
Author:         Sorob Cyrus
Description:    Scalar functions could slowdown our SQL Statements, unless they are Inlineable which
                SQL will process without slowing down. This is how to check if your function is Inlineable
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

Select OB.Name, MO.is_inlineable
FROM 
    sys.sql_modules AS MO
JOIN 
    sys.objects AS OB 
ON 
    OB.object_id = MO.object_id
where MO.is_inlineable > 0
