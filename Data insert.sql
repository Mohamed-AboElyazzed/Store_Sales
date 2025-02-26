INSERT INTO Customers (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT 
    Customer_ID, 
    Customer_Name, 
    Segment
FROM [Superstore-Sales];

INSERT INTO Store_Branches (City, State, Postal_Code, Region)
SELECT DISTINCT 
    City, 
    State, 
    Postal_Code, 
    Region
FROM [Superstore-Sales];

INSERT INTO Ship_Modes (Ship_Mode_Name)
SELECT DISTINCT 
    Ship_Mode
FROM [Superstore-Sales];

SELECT Product_ID, Product_Name, COUNT(*) AS Count
FROM [Superstore-Sales]
GROUP BY Product_ID, Product_Name
HAVING COUNT(*) > 1;
WITH Duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Product_ID ORDER BY (SELECT NULL)) AS RowNum
    FROM [Superstore-Sales]
)
SELECT * FROM Duplicates
WHERE Product_ID IN (
    SELECT Product_ID
    FROM [Superstore-Sales]
    GROUP BY Product_ID
    HAVING COUNT(DISTINCT Product_Name) > 1  -- Ensures only those with different names are included
);
WITH Duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Product_ID ORDER BY (SELECT NULL)) AS RowNum
    FROM [Superstore-Sales]
)
UPDATE Duplicates
SET Product_ID = CONCAT(Product_ID, '-', RowNum)
WHERE Product_ID IN (
    SELECT Product_ID
    FROM [Superstore-Sales]
    GROUP BY Product_ID
    HAVING COUNT(DISTINCT Product_Name) > 1
)
AND RowNum > 1;



INSERT INTO Products (Product_ID, Category, Sub_Category, Product_Name)
SELECT DISTINCT 
    Product_ID, 
    Category, 
    Sub_Category, 
    Product_Name
FROM [Superstore-Sales];

-- Step 1: Store Aggregated Sales in a Temporary Table
SELECT 
    Order_ID, 
    Product_ID, 
    SUM(Sales) AS TotalSales
INTO #AggregatedSales
FROM [Superstore-Sales]
GROUP BY Order_ID, Product_ID;

-- Step 2: Delete Duplicate Records (Retaining Only One)
WITH Duplicates AS (
    SELECT 
        Order_ID, 
        Product_ID, 
        ROW_NUMBER() OVER (PARTITION BY Order_ID, Product_ID ORDER BY Sales DESC) AS RowNum
    FROM [Superstore-Sales]
)
DELETE FROM [Superstore-Sales] 
WHERE Order_ID IN (SELECT Order_ID FROM Duplicates WHERE RowNum > 1)
AND Product_ID IN (SELECT Product_ID FROM Duplicates WHERE RowNum > 1);

-- Step 3: Update Sales with Aggregated Values
UPDATE o
SET o.Sales = a.TotalSales
FROM [Superstore-Sales] o
JOIN #AggregatedSales a
ON o.Order_ID = a.Order_ID AND o.Product_ID = a.Product_ID;

-- Drop the temporary table
DROP TABLE #AggregatedSales;

WITH Store_Branches_CTE AS (
    SELECT 
        City, 
        State, 
        Postal_Code, 
        Region, 
        Store_Branch_ID
    FROM Store_Branches
),
Ship_Modes_CTE AS (
    SELECT 
        Ship_Mode_Name, 
        Ship_Mode_ID
    FROM Ship_Modes
)
INSERT INTO Orders (Order_ID, Order_Date, Ship_Date, Sales, Customer_ID, Store_Branch_ID, Ship_Mode_ID, Product_ID)
SELECT DISTINCT 
    s.Order_ID, 
    CONVERT(DATE, s.Order_Date, 103) AS Order_Date, 
    CONVERT(DATE, s.Ship_Date, 103) AS Ship_Date, 
    CAST(s.Sales AS DECIMAL(10, 4)) AS Sales, 
    s.Customer_ID, 
    sb.Store_Branch_ID, 
    sm.Ship_Mode_ID, 
    s.Product_ID
FROM [Superstore-Sales] s
JOIN Store_Branches_CTE sb 
    ON s.City = sb.City AND s.State = sb.State AND s.Postal_Code = sb.Postal_Code AND s.Region = sb.Region
JOIN Ship_Modes_CTE sm 
    ON s.Ship_Mode = sm.Ship_Mode_Name;

DROP TABLE [Superstore-Sales];


