9create Database Empoloyee_dept_Db;
use Empoloyee_dept_Db;


create table dept(dep_id varchar(3) primary key,depname varchar(20),depmanager varchar(20));

insert into dept values("D01","HEALTH","TIM ARCHER");
insert into dept values("D02","COMMUNICATIONS","ADAM JUSTIN");
insert into dept values("D03","PRODUCT","BRUCE WILLS");
insert into dept values("D04","INSURANCE","ROBERT SWIFT");
insert into dept values("D05","FINANCE","NATASHA STEVENS");


create table employee(e_id varchar(5) ,name varchar(20),dep_id varchar(5) references dept(dep_id),
salary int,managerid varchar(5));


insert into employee values("A114","MARTIN TREDEAU","D01",54497,"A120");
insert into employee values("A116","ROBIN WAYNE","D02",20196,"A187");
insert into employee values("A178","BRUCE WILLS","D03",66861,"A298");
insert into employee values("A132","PAUL VINCENT","D01",94791,"A120");
insert into employee values("A198","TOM HANKS","D02",16879,"A187");
insert into employee values("A120","TIM ARCHER","D01",48834,"A298");
insert into employee values("A143","BRAD MICHAEL","D01",24488,"A120");
insert into employee values("A187","ADAM JUSTIN","D02",80543,"A298");
insert into employee values("A121","STUART WILLIAM","D02",78629,"A187");
insert into employee values("A187","ROBERT SWIFT","D04",27700,"A298");
insert into employee values("A176","EDWARD CANE","D01",89176,"A120");
insert into employee values("A142","TARA CUMMINGS","D04",99475,"A187");
insert into employee values("A130","VANESSA PARY","D04",28565,"A187");
insert into employee values("A128","ADAM WAYNE","D05",94324,"A165");
insert into employee values("A129","JOSEPH ANGELIN","D05",44280,"A165");
insert into employee values("A165","NATASHA STEVENS","D05",31377,"A298");
insert into employee values("A111","JOHN HELLEN","D01",15380,"A120");
insert into employee values("A194","HAROLLD STEVENS","D02",32166,"A187");
insert into employee values("A133","STEVE MICHELOS","D02",61215,"A187");
insert into employee values("A156","NICK MARTIN","D03",50174,"A178");

select * from employee;
select * from dept;

#1)Select the Employee with the top three salaries
select * from (select salary,dense_rank() over (order by salary desc) as r
from employee) t where r<=3;

#2)Select the Employee with the least salary
select * from (select name,salary,dense_rank() over (order by salary asc) as r
from employee) t where r=1;

#3)Select the Employee who does not have a manager in the department table
select * from employee e left join 
(select e1.e_id,e1.name,e1.managerid,e1.dep_id,e2.name "manager_name" from employee e1 
left join employee e2 on e1.managerid=e2.e_id) as t1 on e.dep_id=t1.dep_id where t1.managerid is null;

#4)Select the Employee who is also a Manager
select e.name from employee e inner join dept d on e.name=d.depmanager;


#5)Select the Empolyee who is a Manager and has least salary
select * from (select e.name,e.salary,dense_rank() over(order by e.salary) as d
 from employee e inner join dept d on e.name=d.depmanager) as t where d=1;

#6)Select the total number of Employees in Communications departments
 select d.depname,count(e.e_id) from employee e inner join dept d on e.dep_id=d.dep_id 
 where depname="Communications";
 
#7)Select the Employee in Finance Department who has the top salary
 select * from (select e.name,e.salary,dense_rank() over (order by salary desc) as d 
 from employee e 
 inner join dept d on e.dep_id=d.dep_id where depname="Finance")as t where d=1;

#8)Select the Employee in product depatment who has the least salary
 select * from (select e.name,e.salary,dense_rank() over (order by salary) as d 
 from employee e 
 inner join dept d on e.dep_id=d.dep_id where depname="Product")as t where d=1;

#9)Select the count of Empolyees in Health with maximum salary
select * from (select e.name,d.depname,e.salary,count(e.e_id),dense_rank() over (order by salary desc) as d 
 from employee e inner join dept d 
 on e.dep_id=d.dep_id 
 where depname="Health") t where d=1;
 
#10)Select the Employees who report to Natasha Stevens
select e.name,d.depmanager from employee e inner join dept d on e.dep_id=d.dep_id 
where d.depmanager="Natasha Stevens";

#11)Display the Employee name,Employee count,Dep name,Dept manager in the Health department
select e.name,count(e_id),d.depname,d.depmanager from employee e 
inner join dept d on e.dep_id=d.dep_id 
where d.depname="Health";

#12)Display the Department id,Employee ids and Manager ids for the Communications department
select d.dep_id,e.e_id,e.managerid,d.depname from employee e 
inner join dept d on e.dep_id=d.dep_id 
where d.depname="Communications";

#13)Select the Average Expenses for Each dept with Dept id and Dept name
select d.depname,avg(e.salary) from employee e inner join dept d  on e.dep_id=d.dep_id 
group by d.dep_id,d.depname;

#14)Select the total expense for the department finance
select d.depname,sum(e.salary) from employee e 
inner join dept d on e.dep_id=d.dep_id 
where d.depname="Finance";

#15)Select the department which spends the least with Dept id and Dept manager name

select * from (select d.depname,sum(salary),dense_rank() over (order by sum(salary)) as d from employee e inner join dept d 
on e.dep_id=d.dep_id group by d.dep_id,d.depmanager) as t where d=1;

#16)Select the count of Employees in each department
select d.depname,count(e_id) from employee e inner join dept d on e.dep_id=d.dep_id 
group by d.depname;

#17)Select the count of Employees in each department having salary <10000
select d.depname,count(e_id) from employee e inner join dept d on e.dep_id=d.dep_id where 
e.salary<20000 group by d.depname;

#18)Select the total number of Employees in Dept id D04
select count(e_id) from employee e inner join dept d on e.dep_id=d.dep_id where d.dep_id='D04';

#19)Select all department details of the Department with Maximum Employees
select * from (select d.depname,count(e_id),dense_rank() over 
(order by count(e_id) desc) as d from employee e inner join 
dept d on e.dep_id=d.dep_id group by d.depname) as t where d=1;


#20)Select the Employees who has Tim Cook as their manager
select e.name from employee e inner join dept d on e.dep_id=d.dep_id
 where d.depmanager="Tim Cook"
