
create table Customer (Customer_id	integer,Cust_Name varchar(20),City varchar(20),Priority_num integer,Salesman_id	integer,Purchased_Amount integer);
create table Salesman(Salesman_Id integer,Salesman_Name varchar(20),City varchar(20),Sales_Manager_id integer,Monthly_Target integer);
select * from customer ;
delete from customer where Customer_id =10;
insert into Customer values(10,'James','Chennai',1,1,10000);
insert into Customer values(20,'Ricky','Chennai',1,3,8000);
insert into Customer values(30,'Ramu','Bangalore',1,2,8000);
insert into Customer values(40,'Jyothi','Hyderabad',2,3,9000);
insert into Customer values(50,'Amaran','Chennai',1,4,3000);
insert into Customer values(60,'Akilan','Hyderabad',2,3,6000);
insert into Customer values(70,'Arun','Chennai',2,5,5000);
insert into Customer values(80,'Dinesh','Mumbai',2,4,6000);

truncate table Salesman;
insert into Salesman values(1,'John','Chennai',2,10000);
insert into Salesman values(2,'Abraham','Bangalore',4,21000);
insert into Salesman values(3,'Raju','Hyderabad',4,21000);
insert into Salesman values(4,'Srinath','Mumbai',5,9000);
insert into Salesman values(5,'Vijay','Chennai',6,4000);
insert into Salesman values(6,'Balaji','Hyderabad',6,15000);

-- 1)Fetch Salesman_Name, Cust_Name, Customer_city,Salesman_City
-- Show only the customer and salesman whole belong to the different City 
select s.Salesman_Name, c.Cust_Name, c.city as Customer_city,s.city as Salesman_City
from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
where  c.city!=s.City;

select s.Salesman_Name, c.Cust_Name, c.city as Customer_city,s.city as Salesman_City
from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
where  c.city<>s.City;

-- 2) Fetch Salesman_Name, City, Monthly_target, Amount_purchase_by_Customer 
-- Show only the Sales Man who achieved the monthly Target
--  Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
select  s.Salesman_Name,s.City,s.Monthly_Target,sum(Purchased_Amount) as Amount_purchase_by_Customer
from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
group by s.Salesman_Name,s.City,s.Monthly_Target having Amount_purchase_by_Customer>=s.Monthly_Target;

-- 3)Fetch Cust_Name, City,Priority_num,Purchased_amount
-- Show only the customer information who is top two  purchased more in their respective priority
-- Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
select Cust_Name, City,Priority_num,Purchased_amount from(
 select Cust_Name, City,Priority_num,Purchased_amount,row_number() over (partition by Priority_num order by Purchased_amount desc) as rn_amount from customer) as a
 where rn_amount<=3;
 

 
-- 4)  Fetch Salesman_Name, City, Amount_purchase_by_Customer 
-- Show only the Sales Man who  Amount_purchase_by_Customer is less than the avg monthly target of all sales person
--  Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
 select  s.Salesman_Name,s.City,s.Monthly_Target,case when c.Purchased_Amount is null then 0
													  else sum(c.Purchased_Amount) end as Amount_purchase_by_Customer
from  Customer as c   right join Salesman as s on c.Salesman_id=s.Salesman_id 
group by s.Salesman_Name,s.City,s.Monthly_Target having Amount_purchase_by_Customer<(select avg(s.Monthly_Target) as avg_monthly_target from Salesman as s );


-- 5) select s.Salesman_Name,s1.Salesman_Name as Sales_Manager_Name ,s1.Monthly_target,sum(c.Purchased_Amount)  as Amount_purchase_by_Customer
--  from Salesman as s inner join Salesman as s1 on s.Sales_Manager_id=s1.Salesman_id inner join Customer as c on 
--  c.Salesman_id=s.Salesman_id 
-- group by s.Salesman_id having s1.Monthly_target<Amount_purchase_by_Customer;//
-- Fetch  Sales_Manager_Name, Salesman_Name,Manager Monthly_target,  Amount_purchase_by_Customer 
--  Show only the Sales Man who's manager is achieved the monthly Target based on his reportees purchase detail
--  Sum of Amount_purchase_by_Customer -- Amount purchased by customer which is sold by it reportees
select emp_salesman_name,mgr_salesman_name,mgr_Monthly_Target,emp_Amount_purchase_by_Customer
from
(select distinct
mgr.salesman_id as mgr_salesman_id,
mgr.salesman_name as mgr_salesman_name,
emp.salesman_name as emp_salesman_name,
mgr.Monthly_Target as mgr_Monthly_Target,
sum(c.Purchased_Amount) over (partition by mgr.salesman_id) as mgr_Amount_purchase_by_Customer ,
sum(c.Purchased_Amount) over (partition by emp.salesman_id) as emp_Amount_purchase_by_Customer 
from
salesman emp
inner join 
Salesman mgr
on emp.Sales_Manager_id = mgr.salesman_id 
inner join 
customer c
on c.salesman_id=emp.salesman_id  ) tmp
where mgr_Monthly_Target <= mgr_Amount_purchase_by_Customer;