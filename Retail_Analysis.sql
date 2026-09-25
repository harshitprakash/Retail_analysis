use retail_analysis;
##--------------------------------Sale KPIS------------------------------

#-----------------Total Orders KPIS-------------------------------

select Count(orderID) as Total_orders from orders;

#-----------------Total Sales-------------------------------

select sum(od.Quantity * p.SellingPrice) As total_sales from orderdetails od
join products p on od.productID = p.productID;

#-------------------total profit-------------------------
SELECT 
    SUM(od.Quantity * (p.SellingPrice - p.CostPrice)) AS Total_Profit
FROM orderdetails od
JOIN products p 
    ON od.ProductID = p.ProductID;
    
#-------------------------Profit Margine---------------------------    
SELECT 
SUM(od.Quantity * (p.SellingPrice - p.CostPrice)) AS Total_Profit,
SUM(od.Quantity * p.SellingPrice) AS Total_Sales,
ROUND(
	SUM(od.Quantity * (p.SellingPrice - p.CostPrice))
	/ SUM(od.Quantity * p.SellingPrice) * 100,
	2
) AS Profit_Margin
FROM orderdetails od
JOIN products p 
    ON od.ProductID = p.ProductID;
#-----------------AVERAGE ORDER VALUES-------------------------------

select sum(od.Quantity * p.SellingPrice)/Count(distinct od.orderID) As average_order_Value from orderdetails od
join products p on od.productID = p.productID;

#-----------------MONTHLY SALES TREND-------------------------------

SELECT  DATE_FORMAT(o.OrderDate, '%Y-%m') AS Sales_Month,sum(od.Quantity * p.SellingPrice) as Monthly_sales from orderdetails od
join products p on od.productID = p.productID
join orders o on od.OrderID = o.OrderID
group by DATE_FORMAT(o.OrderDate, '%Y-%m') 
order by Sales_Month desc;

#-----------------MONTHLY Profit TREND-------------------------------

SELECT  DATE_FORMAT(o.OrderDate, '%Y-%m') AS Months,sum(od.Quantity *(p.SellingPrice - p.CostPrice)) as Monthly_Profit from orderdetails od
join products p on od.productID = p.productID
join orders o on od.OrderID = o.OrderID
group by DATE_FORMAT(o.OrderDate, '%Y-%m') 
order by Months desc;


##--------------------------------   Product Analysis   ------------------------------

#----------------------------------Top selling products-----------------------------

select p.ProductName,sum(p.SellingPrice*od.Quantity) as Total_sales 
from products p
Inner join orderdetails od on od.ProductID = p.ProductID
Group By p.ProductName
Order By Total_sales desc
Limit 10;

#-----------------------------------Profitable Products--------------------------------

select p.ProductName,Round((sum((p.SellingPrice-p.CostPrice)*od.Quantity)/sum(p.sellingPrice*od.Quantity))*100,2) as Product_Profit
from products p
inner join orderdetails od on p.productID = od.productID
group by p.ProductName
order by Product_Profit desc
Limit 10;

#-----------------------------------Best-Selling Category-------------------------------------

select p.Category,Sum(p.SellingPrice*od.quantity) as total_sales
from products p
inner join orderdetails od on p.ProductID = od.ProductID
group by p.Category 
order by total_sales desc
Limit 10; 



#-----------------------------------Products Never Sold----------------------------------


select p.ProductName,p.productID,Category from products p
Left join orderdetails od on p.ProductID = od.ProductID
where od.ProductID IS NULL;

##---------------------------------------------   Customer Analysis   --------------------------------------------------

#----------------------------------Top 5 Customer-------------------------------------

select c.CustomerName,sum(p.SellingPrice*od.Quantity) as Total_Sales 
from customers c
join orders o on c.CustomerID = o.CustomerID
join orderdetails od on od.orderID = o.OrderID
join products p on od.ProductID = p.ProductID
group by c.CustomerName 
order by Total_Sales desc
LIMIT 5;

##--------------------------------    Store & Employee Analysis    ----------------------------

#-------------------------------Revenue by Store-----------------------

select s.StoreName, sum(p.SellingPrice*od.Quantity) as total_sales
from stores s
join orders o on s.StoreID = o.StoreID
join orderdetails od on od.OrderID = o.OrderID
join products p on od.ProductID = p.ProductID
group by s.StoreName
order by total_sales desc;


#-------------------------------Store-wise Profitability--------------------------------
 
 
select s.StoreName, sum((p.sellingPrice-p.CostPrice)*od.Quantity) as total_Profit
from stores s
join orders o on s.StoreID = o.StoreID
join orderdetails od on od.OrderID = o.OrderID
join products p on od.ProductID = p.ProductID
group by s.StoreName
order by total_Profit desc;

#---------------------------Employee Performance------------------------------------

Select e.Name as Employee_Name,sum(p.sellingPrice*od.Quantity) as total_sales
from employees e
join orders o on o.EmployeeID = e.EmployeeID
join orderdetails od on od.orderID = o.OrderID
join products p on od.ProductID = p.ProductID
group by e.Name 
order by total_Sales desc;

#---------------------------Employee Ranking as per sales------------------------------------

Select e.Name as Employee_Name,sum(p.sellingPrice*od.Quantity) as total_sales
from employees e
join orders o on o.EmployeeID = e.EmployeeID
join orderdetails od on od.orderID = o.OrderID
join products p on od.ProductID = p.ProductID
group by e.Name 
order by total_Sales desc
limit 10;