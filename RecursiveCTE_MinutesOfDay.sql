/***************************************************************************************************
Create Date:    2021-03-01 
Author:         Sorob Cyrus
Description:    With Recursion, we can create simple Minute by minute reference table
				This can also be expanded to Hours, days, weeks, etc. 
****************************************************************************************************/

;WITH MinuteCTE ([Time]) AS
	(SELECT CAST('20201231 00:00:00' AS DATETIME)			
	UNION ALL
	SELECT DATEADD(MINUTE, 1, [Time]) 
	FROM MinuteCTE
	WHERE [Time] < CAST('20210101 00:00:00' AS DATETIME)
	)
SELECT 
    [Time]
    ,DATEPART(HOUR, [Time]) as Hrs
    ,DATEPART(MINUTE, [Time]) as Mins
FROM MinuteCTE 
OPTION(MAXRECURSION 1443)
go