Create Database Customers_Orders_Products 

Use Customers_Orders_Products
go

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100));

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');
  
  Select* from Customers

  CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT);

 Select * from Orders

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

  
CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

Select* from Products

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);


  ----------TASK 1---------------------------------------

--1. Write a query to retrieve all records from the Customers table..

SELECT * from Customers
   
--2. Write a query to retrieve the names and email addresses of customers whose names start with 'J'.

SELECT Name, Email 
FROM Customers
WHERE Name LIKE 'J%';

--3. Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders..

SELECT OrderID, ProductName, Quantity 
FROM Orders;

--4. Write a query to calculate the total quantity of products ordered.

SELECT SUM(Quantity) AS TotalQuantity 
FROM Orders;

--5. Write a query to retrieve the names of customers who have placed an order.

Select * From Customers
Select * From Orders

SELECT DISTINCT c.Name 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

--6. Write a query to retrieve the products with a price greater than $10.00.

Select * from Products

SELECT ProductName,Price
FROM Products 
WHERE Price > 10.00;

--7. Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'.

Select * From Customers
Select * From Orders

SELECT c.Name, o.OrderDate 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-07-05';

--8. Write a query to calculate the average price of all products.

Select * From Products

SELECT ProductName, AVG(Price) AS AveragePrice 
FROM Products
GROUP BY ProductName;

--9.	Write a query to retrieve the customer names along with the total quantity of products they have ordered.

Select * From Customers
Select * From Orders

SELECT c.Name, SUM(o.Quantity) AS TotalQuantityOrdered 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name;

--10.	Write a query to retrieve the products that have not been ordered.

Select * From Orders
Select * From Products

SELECT * 
FROM Products 
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders);

---------------------------------------------------------------------------------------------------------------------------

--------------- TASK 2----------------------------

----1. Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.

Select * from Orders
Select * from Customers

SELECT Top 5 C.Name, Sum(Quantity) As highest_total_quantity
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name
Order BY highest_total_quantity desc;

--2. Write a query to calculate the average price of products for each product category.

Select * From Products

SELECT P.ProductName, AVG(p.Price) AS AveragePrice
FROM Products P
GROUP BY P.ProductName;

--3. Write a query to retrieve the customers who have not placed any orders.

Select * From Customers;
Select * From Orders;

--APPROACH 1--
SELECT C.CustomerID, C.Name, O.ProductName, O.orderDate, O.Quantity 
FROM Customers C
INNER JOIN orders O
ON C.CustomerID=O.customerID where O.OrderDate is null;

--APPROACH 2--
Select * 
From Customers where CustomerID NOT IN (Select CustomerID From Orders);

--4. Write a query to retrieve the order details (OrderID, ProductName, Quantity) 
--for orders placed by customers whose names start with 'M'.

Select * from Orders;
Select * from Customers;

SELECT C.Name,O.OrderID,O.Quantity 
FROM Customers C 
INNER JOIN Orders O on C.CustomerID=O.CustomerID 
WHERE Name like 'M%';

--5. Write a query to calculate the total revenue generated from all orders.

Select * From Orders;
Select * From Products;

SELECT Sum(O.Quantity*P.Price) as Total_revenue
FROM Orders O
INNER JOIN Products P ON O.ProductName = P.ProductName

--6. Write a query to retrieve the customer names along with the total revenue generated from their orders.

Select * From Customers;
Select * From Orders;
Select * From Products;

SELECT  C.name, SUM(O.Quantity * P.Price) as total_Revenue
FROM Customers C
INNER JOIN Orders O ON C.customerID=O.customerID 
INNER JOIN Products P on O.ProductName=P.ProductName
GROUP BY C.name
ORDER BY total_Revenue Desc;

--7. Write a query to retrieve the customers who have placed at least one order for each product category.

select orders.ProductName, Customers.Name,Orders.Quantity from Customers left join  Orders
on Customers.CustomerID=Orders.CustomerID where Quantity  is not null
order by ProductName

-- 8.	Write a query to retrieve the customers who have placed orders on consecutive days

SELECT C.Name , O.OrderDate 
FROM Customers C 
LEFT JOIN Orders O on C.CustomerID=O.CustomerID
ORDER BY O.OrderDate;

-- 9.	Write a query to retrieve the top 3 products with the highest average quantity ordered

Select * From Orders;
Select * From Products;

SELECT TOP 3 O.ProductName, AVG(O.Quantity) AS highest_average_quantity
FROM Orders O 
Inner JOIN Products P ON O.ProductName =P.ProductName
GROUP BY O.ProductName,P.ProductName
ORDER BY highest_average_quantity DESC;


 ---------------------------------------------------------------------------------------------------------------------------
--------------- TASK 3----------------------------

--1. Write a query to retrieve the customers who have placed orders for all products.

Select * From Customers
Select * From Orders
Select * From Products

SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT CustomerID) = (SELECT COUNT(DISTINCT ProductID) FROM Products)


--2. Write a query to retrieve the products that have been ordered by all customers.

SELECT C.name,O.productName 
FROM Customers C 
INNER JOIN orders O ON C.customerID = O.customerID 
ORDER BY O.productName

--3. Write a query to calculate the total revenue generated from orders placed in each month.
select (orders.quantity*products.price)  'total_revenue',orders.orderdate from orders full join
products on orders.orderID = products.productID order by orderdate desc
select * from orders


--4. Write a query to retrieve the top 5 customers who have spent the highest amount of money on orders.

Select * From Customers
Select * From Orders
Select * From Products

SELECT top 5 C.CustomerID,C.Name, Sum (O.Quantity * P.Price) as Highest_Money_Spend
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID=O.CustomerID
INNER JOIN Products P ON O.ProductName=P.ProductName
GROUP BY C.CustomerID,C.Name
ORDER BY Highest_Money_Spend DESC;


--5. Write a query to retrieve the top 3 most recent orders for each customer.

Select * From Customers
Select * From Orders

SELECT  TOP 3 C.CustomerID,C.Name,o.OrderDate
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID=O.CustomerID 
order by orderdate desc

--6. Write a query to calculate the total revenue generated by each customer in the last 30 days.

Select * From Customers
Select * From Orders
Select * From Products

SELECT C.CustomerID,Sum(O.Quantity * P.Price) As Total_revenue 
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID=O.CustomerID
INNER JOIN Products P ON O.ProductName=P.ProductName
WHERE O.OrderDate <= DATEADD(DAY,-30,GETDATE())
GROUP BY C.CustomerID
ORDER BY Total_revenue Desc;

SELECT Sum(quantity*price)total_revenue_last_month 
FROM orders join products on 
orders.orderID = products.productID 
WHERE orderdate between '2023/07/01' and '2023/07/30'

--7. Write a query to retrieve the customers who have placed orders for at least two different product categories.

Select * From Customers;
Select * From Orders;
Select * From Products;

SELECT C.CustomerID,C.Name
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID=O.CustomerID
INNER JOIN Products P ON O.ProductName=P.ProductName
GROUP BY C.CustomerID,C.Name
HAVING COUNT(P.ProductName)>=2;

--8. Write a query to calculate the average revenue per order for each customer.

SELECT sum(quantity*price)/25 AS avg_revenue_customer 
FROM orders 
INNER JOIN products ON orders.orderID = products.productID ;

--9. Write a query to retrieve the customers who have placed orders for every month of a specific year.

SELECT customerID 
FROM orders 
WHERE month(OrderDate)= '07' and year(orderdate)='2023';
