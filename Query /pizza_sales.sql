use Pizza_DB;

SELECT COUNT()
  FROM pizza_sales;

SELECT *
  FROM pizza_sales;

--  Total Revenue
SELECT 
    ROUND(SUM(total_price),2) AS Total_Revenue
	FROM pizza_sales;

-- Average Order value
SELECT 
   ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS Avg_order_value
FROM pizza_sales;

--- Total pizzas Sold
SELECT 
    SUM(quantity) AS Total_Pizzas_Sold
  FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
  FROM pizza_sales;

-- Average Pizzas Per Order:
SELECT 
  CAST( CAST(SUM(quantity) AS DECIMAL (10,2))/
  CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2))
  AS DECIMAL(10,2)) AS Avg_pizza_per_order
  FROM pizza_sales;

 --  CHARTS ------
 -- Daily Trend for Orders
 SELECT 
    DATENAME(DW, order_date) AS Order_Day, 
	COUNT(DISTINCT order_id ) AS Total_Orders
 FROM pizza_sales
 GROUP BY DATENAME(DW, order_date);

 -- Monthly Trend for total Orders;
 SELECT 
    DATENAME(MONTH, order_date) AS Month_Name, 
	COUNT(DISTINCT order_id ) AS Total_Orders
 FROM pizza_sales
 GROUP BY DATENAME(MONTH, order_date)
 ORDER BY Total_Orders DESC;

 -- Percentage of Sales by Pizza Category:
SELECT 
    pizza_category,
    CAST(SUM(total_price) * 100/ (
	SELECT SUM(total_price)
  	FROM pizza_sales
	WHERE MONTH(order_date) = 1)AS DECIMAL(10,2)) AS Percentage_of_sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

 -- Percentage of Sales by Pizza Size:



-- Top 5 best Sellers by Revenue, total quantity and total orders.
SELECT TOP 5
    pizza_name,
	SUM(quantity) AS Total_Quantity,
    SUM(total_price) AS Total_Revenue,
	SUM(order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Bottom 5 best Sellers by Revenue, total quantity and total orders.
SELECT TOP 5
    pizza_name,
	SUM(quantity) AS Total_Quantity,
    SUM(total_price) AS Total_Revenue,
	SUM(order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;
