CREATE TABLE Customers (
    Customer_ID NVARCHAR(20) PRIMARY KEY,
    Customer_Name NVARCHAR(100),
    Segment NVARCHAR(50)
);
CREATE TABLE Store_Branches (
    Store_Branch_ID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-incrementing ID
    City NVARCHAR(100),
    State NVARCHAR(50),
    Postal_Code NVARCHAR(20),
    Region NVARCHAR(50)
);
CREATE TABLE Ship_Modes (
    Ship_Mode_ID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-incrementing ID
    Ship_Mode_Name NVARCHAR(50)
);

CREATE TABLE Products (
    Product_ID NVARCHAR(20) PRIMARY KEY,
    Category NVARCHAR(50),
    Sub_Category NVARCHAR(50),
    Product_Name NVARCHAR(MAX)
);
CREATE TABLE Orders (
    Order_ID NVARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Sales DECIMAL(10, 4),
    Customer_ID NVARCHAR(20),
    Store_Branch_ID INT,
    Ship_Mode_ID INT,
    Product_ID NVARCHAR(20),
	PRIMARY KEY (Order_ID,Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Store_Branch_ID) REFERENCES Store_Branches(Store_Branch_ID),
    FOREIGN KEY (Ship_Mode_ID) REFERENCES Ship_Modes(Ship_Mode_ID),
	FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);
