/***************************************************************************************************
File: AntiJoin.sql
----------------------------------------------------------------------------------------------------
Create Date:    2021-01-01 
Author:         Sorob Cyrus
Description:    How to define an antijoin (e.g. Find those customers who have not ordered)
                Instead of a long Not exists, we can use Except!
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

SELECT ColumnName
FROM Customers
EXCEPT
    SELECT ColumnName
    FROM
        Customers
    JOIN
        Orders 
    ON  
        Customers.CustomerID = Orders.CustomerID
