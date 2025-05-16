-- Assignment: Database Design and Normalization
-- Author: NYAMIRA NATHAN ORANGI
-- File: answers.sql

-- =========================================================
-- Question 1: Achieving First Normal Form (1NF)
-- =========================================================
-- The original table 'ProductDetail' violates 1NF because
-- the 'Products' column contains multiple values.
-- Solution: Split products into individual rows per product.

-- Step 1: Create the normalized ProductDetail_1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert normalized data
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Now the data is in 1NF: each cell contains atomic values.

-- =========================================================
-- Question 2: Achieving Second Normal Form (2NF)
-- =========================================================
-- The table 'OrderDetails' is in 1NF but not 2NF.
-- The partial dependency: CustomerName depends only on OrderID,
-- not the entire composite key (OrderID, Product).
-- Solution: Decompose into two tables.

-- Step 1: Create a table for Orders (to remove partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create a table for OrderItems
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 4: Insert data into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- The structure is now in 2NF: all non-key columns fully depend
-- on the full primary key.
