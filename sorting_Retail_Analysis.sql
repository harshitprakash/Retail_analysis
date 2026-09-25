use retail_analysis;

# ----------------------------------------CHECKING ALL TABLES-----------------------------------------------

DESCRIBE customers;
DESCRIBE stores;
DESCRIBE products;
DESCRIBE inventory;
DESCRIBE orders;
DESCRIBE orderdetails;
DESCRIBE employees;
SHOW CREATE TABLE orderdetails;

#----------------------------------------- SHOWING ALL DATA ----------------------------

Select * from customers;
Select * from stores;
Select * from products;
Select * from inventory;
Select * from orders;
Select * from orderdetails;
Select * from employees;

#----------------------------------------- CHECKING COUNT OF TABLES-------------------------------

select count(*) from customers;
Select count(*) from stores;
Select count(*) from products;
Select count(*) from inventory;
Select count(*) from orders;
Select count(*) from orderdetails;
Select count(*) from employees;

#---------------------------CHECKING FOR DUPLICATES--------------------------

SELECT CustomerID,count(*) from customers
group by CustomerID
having count(*)>1;

SELECT employeeID,count(*) from employees
group by employeeID
having count(*)>1;





