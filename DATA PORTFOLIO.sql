
-- A QUERY TO EXTRACT TRANSACTIONS FROM SALES ORDER DETAIL TABLE WHERE LINE TOTAL IS LESS 1000
SELECT [SalesOrderID],[CarrierTrackingNumber],[LineTotal]
FROM [Sales].[SalesOrderDetail]
WHERE [LineTotal] >1000

-- A QUERY TO EXTRACT COLORS
SELECT [ProductID],[Name],[Color]
FROM [Production].[Product]
WHERE [Color] = 'RED' OR [Color] = 'BLACK'

SELECT [ProductID],[Name],[Color]
FROM [Production].[Product]
WHERE [Color] = 'RED' AND [Color] = 'BLACK'

SELECT [ProductID],[Name],[Color]
FROM [Production].[Product]
WHERE [Color] IN ('RED','BLACK','WHITE','MULTI','SILVER')

-- A QUERY TO ARRANGE SOLD PRODUCT UNIT PRICE IN DESC ORDER
SELECT [SalesOrderID], [UnitPrice]
FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderID] > 45000
ORDER BY [UnitPrice] DESC

-- A QUERY TO EXTRACT TWO SPECIFIC ROLES FROM THE EMPLOYEE TABLE
SELECT [BusinessEntityID], [NationalIDNumber], [Gender], [JobTitle]
FROM [HumanResources].[Employee]
WHERE [JobTitle] = 'DESIGN ENGINEER' OR [JobTitle] = 'TOOL DESIGNER' 

-- A QUERY TO EXTRACT LINE TOTAL GREATER THAN 5000 AND SORT FROM MAX TO MIN FROM SALES ORDER DETAIL TABLE
SELECT [SalesOrderID], [LineTotal]
FROM [Sales].[SalesOrderDetail]
WHERE [LineTotal]> 5000
ORDER BY [LineTotal] DESC

-- A QUERY TO TO EXTRACT THE TOP 5 ORGANISATION LEVEL
SELECT TOP 5[OrganizationLevel],[JobTitle]
FROM [HumanResources].[Employee]
WHERE [OrganizationLevel] IS NOT NULL
ORDER BY [OrganizationLevel] DESC

SELECT DISTINCT [JobTitle]
FROM [HumanResources].[Employee]

--COUNT THE NUMBER OF MALE AND FEMALE EMPLOYEES
SELECT [Gender],
       COUNT ([Gender])
	   FROM [HumanResources].[Employee]
GROUP BY [Gender]

--CALCULATE TOTAL ORDER QTY, AVERAGE ORDER QTY, SUM OF LINE TOTAL, AVERAGE UNIT PRICE

SELECT SUM ([OrderQty]) [TOTAL QTY SOLD],
       AVG ([OrderQty]) [AVERAGE QTY],
	   SUM ([LineTotal]) [TOTAL REVENUE],
	    [OnlineOrderFlag]
FROM [Sales].[SalesOrderDetail] AS SOD
LEFT JOIN [Sales].[SalesOrderHeader] AS SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
GROUP BY [OnlineOrderFlag]

--CALCULATE SUM OF TOTAL DUE, AVERAGE TOTAL DUE,
--AGREGATE TOTAL DUE BASED ON ONLINE ORDER FLAG
SELECT SUM ([TotalDue]) AS SUM_OF_TOTAL_DUE, AVG ([TotalDue]) AS AVERAGE_TOTAL_DUE
FROM [Sales].[SalesOrderHeader]

SELECT [OnlineOrderFlag], SUM ([TotalDue]) AS SUM_OF_TOTAL_DUE
FROM [Sales].[SalesOrderHeader]
GROUP BY [OnlineOrderFlag]

--EXTRACT LAST NAME THAT ENDS WITH ED
SELECT [LastName]
FROM [Person].[Person]
WHERE [LastName] LIKE ('%ED')

-- CREATE A CONDITIONAL FILTER
SELECT [BusinessEntityID], [JobTitle],
CASE 
    WHEN [Gender] = 'F' THEN 'FEMALE'
	ELSE 'MALE'
	END AS GENDER
FROM [HumanResources].[Employee]

-- A QUERY TO EXTRACT ALL MALE EMPLOYEES WHO ARE ALSO SINGLE
SELECT[BusinessEntityID], [Gender], [MaritalStatus]
FROM [HumanResources].[Employee]
WHERE [Gender] = 'M' AND [MaritalStatus] = 'S'

-- A QUERY TO SEGMENT LINE TOTAL FROM SALES ORDER DETAIL INTO HIGH AND LOW WHERE HIGH SALE IS ANY SALE GREATER THAN 1000
SELECT [LineTotal],
CASE   
       WHEN [LineTotal] > 1000 THEN 'HIGH'
       ELSE 'LOW'
       END AS AMOUNT
FROM [Sales].[SalesOrderDetail]
        
-- A QUERY TO AGGREGATE THE AVERAGE AMOUNT OF SICK LEAVE HOURS FOR MARRIED AND SINGLE EMPLOYEES
SELECT [MaritalStatus], 
        AVG ([SickLeaveHours]) AS _AVERAGE_SICKLEAVE_HOURS 
FROM [HumanResources].[Employee]
GROUP BY [MaritalStatus]

-- PRESENT AGE, HIRE AGE, HOW MANY YEARS TILL RETIREMENT 
SELECT [BusinessEntityID],[JobTitle],
YEAR ([BirthDate]) AS BIRTH_YEAR,
YEAR ([HireDate]) AS HIRE_YEAR
FROM [HumanResources].[Employee]

SELECT [BusinessEntityID],[JobTitle],
MONTH ([BirthDate]) AS BIRTH_MONTH,
MONTH ([HireDate]) AS HIRE_MONTH
FROM [HumanResources].[Employee]

SELECT [BusinessEntityID],[JobTitle],
DAY ([BirthDate]) AS BIRTH_MONTH,
DAY ([HireDate]) AS HIRE_MONTH
FROM [HumanResources].[Employee]

-- DATE NAME , DATE PART
SELECT [BusinessEntityID],
    [JobTitle], DATENAME (MONTH,[BirthDate]) AS MONTH_OF_BIRTH ,DATENAME (MONTH,[HireDate]) AS MONTH_OF_HIRE
	FROM [HumanResources].[Employee]

SELECT [BusinessEntityID],
    [JobTitle], CONCAT(DAY ([BirthDate]),' ','OF',' ', DATENAME (MONTH,[BirthDate]),YEAR ([BirthDate])) AS DATE_OF_BIRTH
	FROM [HumanResources].[Employee]

SELECT [BusinessEntityID],
    [JobTitle], DATENAME (WEEKDAY,[BirthDate]) AS DAY_OF_BIRTH ,DATENAME (WEEKDAY,[HireDate]) AS DAY_OF_HIRE
	FROM [HumanResources].[Employee]

SELECT [BusinessEntityID],
    [JobTitle], DATEDIFF (YEAR,[BirthDate],GETDATE()) AS ACTUAL_AGE,
	            DATEDIFF (YEAR,[BirthDate],[HireDate]) AS HIRE_AGE,
	            DATEDIFF (YEAR,[HireDate],GETDATE()) AS SERVICE_YEARS
	FROM [HumanResources].[Employee]

	-- A QUERY TO EXTRACT THE MALE EMPLOYEE WHO HAVE WORKED FOR NOT LESS THAN 13 YEARS
	SELECT [Gender], DATEDIFF (YEAR,[BirthDate],GETDATE()) AS ACTUAL_AGE,
	            DATEDIFF (YEAR,[BirthDate],[HireDate]) AS HIRE_AGE,
	            DATEDIFF (YEAR,[HireDate],GETDATE()) AS [SERVICE YEARS]
	FROM [HumanResources].[Employee]
	WHERE DATEDIFF (YEAR,[HireDate],GETDATE()) >= '13' AND [Gender] = 'M'

SELECT [BusinessEntityID],
        [JobTitle],
        [Gender],
        [HireDate],
		YEAR(DATEADD(YEAR,35,[HireDate])) AS RETIREMENT_DATE
FROM [HumanResources].[Employee]

SELECT [Gender],
				DATEDIFF (YEAR,[BirthDate],[HireDate]) AS HIRE_AGE,
	            DATEPART(MONTH,[BirthDate]) AS MONTH
	FROM [HumanResources].[Employee]


-- QUERY TO MAKE A PAYROLL OF EMPLOYEES
SELECT HRE.[BusinessEntityID],PP.[FirstName],PP.[LastName],HRE.[JobTitle],HRE.[Gender],ROUND (HREP.[Rate],2) AS WAGERATE
FROM [HumanResources].[Employee] AS HRE
LEFT JOIN [Person].[Person] AS PP
ON HRE.[BusinessEntityID] = PP.[BusinessEntityID]
LEFT JOIN [HumanResources].[EmployeePayHistory] AS HREP
ON HRE.[BusinessEntityID] = HREP.[BusinessEntityID]

SELECT SS.[SalesOrderID],PP.[Name],PP.[Color],SS.[OrderQty],SS.[UnitPrice],SS.[LineTotal]
FROM [Sales].[SalesOrderDetail] AS SS
LEFT JOIN [Production].[Product] AS PP
ON SS.[ProductID] = PP.[ProductID]


-- A QUERY TO RETRIEVE INFORMATION ABOUT PRODUCTS WITH COLOR,LIST PRICE
SELECT [ProductID] ,[Color] ,[ListPrice] AS STANDARD_COST_TO_PRICE
FROM [Production].[Product]
WHERE [Color] IS NOT NULL AND [Color] NOT IN ('RED','SILVER','BLACK','WHITE')
	AND [ListPrice] >= '75' AND [ListPrice] <= '750' 
ORDER BY [ListPrice] DESC

-- A QUERY TO EXTRACT ALL MALE & FEMALE EMPLOYEES BORN WITHIN A PERIOD WITH CONDITIONS ON THIER HIRE DATE
SELECT [BusinessEntityID], [Gender], 
YEAR ([BirthDate]) AS BIRTH_YEAR,
YEAR ([HireDate]) AS HIRE_YEAR
FROM [HumanResources].[Employee]
WHERE [Gender] = 'M'
     AND YEAR ([BirthDate]) >= '1962' 
	 AND YEAR ([BirthDate]) <= '1970' 
	 AND YEAR ([HireDate]) > 2001


SELECT [BusinessEntityID], [Gender], 
YEAR ([BirthDate]) AS BIRTH_YEAR,
YEAR ([HireDate]) AS HIRE_YEAR
FROM [HumanResources].[Employee]
WHERE [Gender] = 'F'
     AND YEAR ([BirthDate]) >= '1972' 
	 AND YEAR ([BirthDate]) <= '1975' 
	 AND YEAR ([HireDate]) IN ('2011','2012')

-- EXPENSIVE PRODUCTS BEGINNING WITH 'BK'
SELECT TOP(10)[ListPrice],[ProductNumber],[ProductID],[Name],[Color]
FROM [Production].[Product]
WHERE [ProductNumber] LIKE ('BK%') 
ORDER BY [ListPrice] DESC

-- BASIC INFO ON PEOPLE WITH CONDITIONS ON THIER FIRST & LAST NAMES
SELECT PP.[BusinessEntityID],PP.[LastName],PEA.[EmailAddress],PP.[FirstName],
       CONCAT([FirstName],' ',[LastName]) AS FULL_NAME
FROM [Person].[Person] AS PP
LEFT JOIN [Person].[EmailAddress] AS PEA
ON PP.[BusinessEntityID] = PEA.[BusinessEntityID]
WHERE LEFT ([LastName],4) = LEFT ([EmailAddress],4)
      AND LEFT ([FirstName],1) = LEFT ([LastName],1)

-- SUB-CATEGORIES THAT TAKE AN AVERAGE OF 3 DAYS OR MORE TO MANUFACTURE
SELECT [ProductSubcategoryID],AVG ([DaysToManufacture]) AS AVERAGE_DAYS_TO_MANUFACTURE
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]
HAVING AVG([DaysToManufacture]) >= '3'

-- PRODUCT SEGMENTATION BY SOME GIVING CRITERIA
SELECT [ProductID], [ListPrice],
CASE
    WHEN [ListPrice] < '200' THEN 'LOW VALUE'
	WHEN [ListPrice] >= '201' AND [ListPrice] <= '750' THEN 'MID VALUE'
	WHEN [ListPrice] >'750' AND [ListPrice] <= '1250' THEN 'MID TO HIGH VALUE'
	ELSE 'HIGHER VALUE'
	END AS PRODUCT_SEGMENTATION
FROM [Production].[Product]