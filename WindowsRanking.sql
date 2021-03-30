/***************************************************************************************************
Create Date:    2021-03-01 
Author:         Sorob Cyrus
Description:    We are going to use RANK, PARTITION BY, RANGE and ROWS to create some reports  
****************************************************************************************************/

DROP TABLE IF EXISTS [dbo].[RankingTable];
GO

CREATE TABLE [dbo].[RankingTable](
	ID			INT NOT NULL IDENTITY PRIMARY KEY,
	[Name]		[varchar](50) NULL,
	Sales		[int] NULL,
	[Location]	[nchar](10) NULL
) 
GO

INSERT INTO [RankingTable]
           ([Name]
           ,[Sales]
           ,[Location])
     VALUES
           ('Nathan',10000,'North'),
		   ('Norma',12000,'North'),
		   ('Sam',12000,'South'),
		   ('Simon',15000,'South'),
		   ('Steve',10000,'South'),
		   ('Sanyai',11000,'South'),
           ('Wes',10000,'West'),
		   ('William',12000,'West'),
		   ('Wilma',12000,'West'),
		   ('Ed',15000,'East'),
		   ('Emma',10000,'East'),
		   ('Ewan',11000,'East')
GO

DROP TABLE IF EXISTS dbo.RegionalSales;
GO

CREATE TABLE RegionalSales(
	SalesID		INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SalesTeam	NVARCHAR(50) NOT NULL,
	Country		NVARCHAR(50) NOT NULL,
	AnnualSales INT NOT NULL
	);
GO
   
INSERT INTO RegionalSales 
	(SalesTeam, Country, AnnualSales)
VALUES
('America', 'States', 30000),
('America', 'Canada', 21000),
('America', 'Mexico', 18000),
('Europe', 'France', 19000),
('Europe', 'Germany', 22000),
('Europe', 'UK', 18000),
('Europe', 'Cyprus', 16000),
('Europe', 'Spain', 16000),
('Europe', 'Turkey', 12000),
('Asia', 'China', 33000),
('Asia', 'Singapore', 24000),
('Asia', 'Thailand', 18000),
('Asia', 'Japan', 24000);
GO

-- Difference between RANK and DENSE_RANK
SELECT [name],sales,[location], RANK() OVER (ORDER BY sales ASC) AS Sales_Rank FROM RankingTable
SELECT [name],sales,[location], DENSE_RANK() OVER (ORDER BY sales ASC) AS Sales_Rank FROM RankingTable

--Including Partition, to partition based on location. each location will be seperated then will be sorted.
SELECT [name],sales,[location], RANK() OVER (PARTITION BY [location] ORDER BY sales ASC) AS Sales_Rank FROM RankingTable


--ROW_NUMBER() provides the number based on the position of the record in the resultset.
-- PARTITION BY, groups the data based on the Partitioned field. 
SELECT [name],sales,[location], ROW_NUMBER() OVER (PARTITION BY [location] ORDER BY sales ASC) AS Sales_Rank FROM RankingTable

--NTILE divides the results set to even sections. 
SELECT NTILE(3) OVER (ORDER BY sales ASC) AS Sales_Rank, [name],sales,[location]  FROM RankingTable

--Notice the difference when Including PARTITION BY
SELECT NTILE(3) OVER (PARTITION BY [location] ORDER BY sales ASC) AS Sales_Rank, [name],sales,[location]  FROM RankingTable


-- One easy way to create a report based on AnnualSales
SELECT 
    SalesTeam,
    Country,
    AnnualSales,
    AnnualSales * 100 / (SUM(AnnualSales) OVER(PARTITION BY SalesTeam)) AS PercentToTotal,
    AnnualSales * 100 / (AVG(AnnualSales) OVER(PARTITION BY SalesTeam)) AS PercentToAVG
FROM
    RegionalSales;



--Rating the sales team based on Annual sales
--Notice the difference between RANGE and ROWS 
SELECT 
    SalesTeam,
    Country,
    AnnualSales,
    COUNT(AnnualSales) OVER(PARTITION BY SalesTeam ORDER BY AnnualSales DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CountryCount,
    SUM(AnnualSales) OVER(PARTITION BY SalesTeam ORDER BY AnnualSales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalSales
FROM
    RegionalSales;