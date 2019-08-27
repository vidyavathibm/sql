create database dummy;
use dummy;
create table emp(empid int(10) primary key,emp_name varchar(50),emp_sal float(20,2),
dept_id  int(50) references dept(dept_id));
create table dept(dept_id int(50) primary key,dept_name varchar(50));
insert into emp values(10,"Vivek",2000.00,1);
insert into emp values(20,"Raj",3000.00,1);
insert into emp values(30,"Vinoth",4000.00,1);
insert into emp values(40,"Abhishek",5000.00,2);
insert into emp values(50,"Divya",6000.00,2);
insert into emp values(60,"Chaithra",7000.00,3);


insert into dept values(1,"IT");
insert into dept values(2,"Admin");
insert into dept values(4,"HR");

select * from emp;
select * from dept;

#1)Fetch all the Deptid,DeptName from department table & Corresponding Department salary using Employee
#  Table. If Any department is not available in employee table then assign salary as 0.
#Note: Don’t use sub quesry or in or not in
select distinct A.dept_name,case when A.tot_sum is null then 0 else A.tot_sum  end as Sum_sal from(select d.dept_id,d.dept_name,e.emp_sal,sum(e.emp_sal) over (order by e.dept_id) as tot_sum
from dept d left join emp e on d.dept_id=e.dept_id) as A;

#2)Fetch all the Deptid &  aggregate all the salary for the respective dept id from Employee table & Corresponding Department name using department Table. If Any department is not available in department table then assign departname as 'Others'
#Note: Don’t use sub quesry or in or not in
select distinct A.dep,sum_sal from (select d.dept_id,d.dept_name,case when d.dept_name is null then "Öthers"
else d.dept_name end as dep,e.emp_sal,sum(e.emp_sal) over (order by e.dept_id) as sum_sal
 from emp e left join dept d on e.dept_id=d.dept_id) as A;
 
 
#select distinct A.dept_id,A.dept_name,sum_sal from (select d.dept_id,d.dept_name,e.emp_sal,sum(e.emp_sal) over (order by e.dept_id) as sum_sal
#from emp e left join dept d on e.dept_id=d.dept_id) as A group by dept_id,dept_name,sum_sal;
 
 
#9)Fetch emp_id,Emp_name,Dept_name & Salary who is getting salary greater than 3000
#int 'IT' and  salary greater than 3400 int 'Admin'
select * from(select e.empid,e.emp_name,d.dept_name,case when e.emp_sal>3000 and d.dept_name="IT" then e.emp_sal
							 when e.emp_sal>3400 and d.dept_name="Admin" then e.emp_sal
                             else null end as salary from emp e inner join 
dept d on e.dept_id=d.dept_id) A where salary is not null;
 
 select empid,emp_name regexp [%b%e%h%],emp_sal from emp;
 
#7)Fetch emp_id,Emp_name & Salary who is getting 2nd maximum salary

select * from (select e.empid,e.emp_name,e.emp_sal,dense_rank() over (order by emp_sal desc) as d 
 from emp e 
 inner join dept d on e.dept_id=d.dept_id)as t where d=2;
 
#8)Fetch emp_id,Emp_name & Salary who is getting top 3 salary
#Note : Don’t use top 
 select * from (select e.empid,e.emp_name,e.emp_sal,dense_rank() over (order by emp_sal desc) as d 
 from emp e 
 inner join dept d on e.dept_id=d.dept_id)as t where d<=3;
 
#5)Fetch all the emp_id & derv_Emp_Name 
#*  Derv_emp_name will be from 4th character till end of the chanracter from emp_name
#Note: Don’t use regular expression

select empid,right(emp_name,length(emp_name)-3) as derv_emp_name from emp; 
select empid,substring(emp_name,4) as derv_emp_name from emp; 

#6)Fetch all the emp_id & derv_Emp_Name 
#*  Derv_emp_name will be from first occurance of 'h' till  end of the chanracter from emp_name
#Note: Don’t use regular expression
select empid,substr(emp_name,char_index(emp_name,'h'),length(emp_name)-1) as derv_emp_name from emp; 

#10)Fetch emp_id,Emp_name,Dept_name & Salary who is having sring 'J' in emp_name

select empid,emp_name,dept_name,emp_sal from emp e inner join dept d on e.dept_id=d.dept_id
where emp_name like '%j%';


