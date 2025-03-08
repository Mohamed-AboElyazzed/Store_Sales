
SELECT Store_Branch_ID, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Store_Branch_ID
ORDER BY Total_Sales DESC;

SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Customer_ID
ORDER BY Total_Sales DESC;

SELECT Product_ID, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Product_ID
ORDER BY Total_Sales DESC;

SELECT p.Category, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

SELECT YEAR(Order_Date) AS Order_Year, MONTH(Order_Date) AS Order_Month, COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;

SELECT YEAR(Order_Date) AS Order_Year, MONTH(Order_Date) AS Order_Month, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;


SELECT Product_ID, COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY Product_ID
ORDER BY Total_Orders DESC;

SELECT Product_ID, COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY Product_ID
ORDER BY Total_Orders ASC;

SELECT AVG(Total_Order_Sales) AS Average_Order_Value
FROM (
    SELECT Order_ID, SUM(Sales) AS Total_Order_Sales
    FROM Orders
    GROUP BY Order_ID
) AS Order_Sales;

SELECT Order_ID, COUNT(DISTINCT Product_ID) AS Unique_Products
FROM Orders
GROUP BY Order_ID
ORDER BY Unique_Products DESC;


SELECT p.Sub_Category, COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Sub_Category
ORDER BY Total_Orders DESC;
 
SELECT p.Category, AVG(CAST(o.Sales AS FLOAT)) AS Average_Sales
FROM Orders o
JOIN Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Average_Sales DESC;
SELECT p.Product_ID, p.Product_Name, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Sales DESC;

SELECT COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM Orders;

SELECT c.Segment, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;


SELECT sb.Store_Branch_ID, sb.City, sb.State, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Store_Branches sb ON o.Store_Branch_ID = sb.Store_Branch_ID
GROUP BY sb.Store_Branch_ID, sb.City, sb.State
ORDER BY Total_Sales DESC;
 

SELECT sb.Region, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Store_Branches sb ON o.Store_Branch_ID = sb.Store_Branch_ID
GROUP BY sb.Region
ORDER BY Total_Sales DESC;


SELECT sm.Ship_Mode_ID, sm.Ship_Mode_Name, COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Ship_Modes sm ON o.Ship_Mode_ID = sm.Ship_Mode_ID
GROUP BY sm.Ship_Mode_ID, sm.Ship_Mode_Name
ORDER BY Total_Orders DESC;


SELECT sm.Ship_Mode_ID, sm.Ship_Mode_Name, SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Ship_Modes sm ON o.Ship_Mode_ID = sm.Ship_Mode_ID
GROUP BY sm.Ship_Mode_ID, sm.Ship_Mode_Name
ORDER BY Total_Sales DESC;


SELECT SUM(Sales) AS Total_Sales
FROM Orders;

SELECT AVG(CAST(Sales AS FLOAT)) AS Average_Order_Value
FROM Orders;

SELECT COUNT(Order_ID) AS Total_Orders
FROM Orders;
 

SELECT AVG(Customer_Sales.Avg_Sales) AS Sales_Per_Customer
FROM (
    SELECT Customer_ID, AVG(CAST(Sales AS FLOAT)) AS Avg_Sales
    FROM Orders
    GROUP BY Customer_ID
) AS Customer_Sales;


SELECT TOP 1 p.Product_ID, p.Product_Name, COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Products p ON o.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Orders DESC;
