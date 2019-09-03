create database empassign;
use empassign;
create table employee(emp_id int primary key,emp_name varchar(50),desc_id int references designation(desc_id),
place_id int references place(place_id),proj_id int references project(proj_id));
create table designation(desc_id int primary key,desc_name varchar(50),role_type varchar(50));
create table place(place_id int primary key,place_desc varchar(50),place_type varchar(50));
create table project(proj_id int,proj_name varchar(50));

insert into employee values(1,'Vijaykumar',10,1,3);
insert into employee values(2,'Raja',20,3,4);
insert into employee values(3,'Abhisheksingh',10,4,5);
insert into employee values(4,'Santosh',30,2,1);
insert into employee values(5,'Kribakaran',20,3,2);
insert into employee values(6,'Divya',40,5,3);
insert into employee values(7,'Suganya',10,3,4);
insert into employee values(8,'Shalini',20,2,2);
insert into employee values(9,'Avantika',30,1,5);
insert into employee values(10,'Ajay',50,6,8);
insert into employee values(11,'Tamilselvan',60,7,6);
insert into employee values(12,'Vinodha',70,6,7);
insert into employee values(13,'Karthick',60,5,2);
insert into employee values(14,'Sanjay',70,6,5);
insert into employee values(15,'Meera',60,8,7);

insert into designation values(10,'ASE','DEVELOPER');
insert into designation values(20,'SE','DEVELOPER');
insert into designation values(30,'SSE','DEVELOPER');
insert into designation values(40,'TL','LEAD');
insert into designation values(50,'AM','LEAD');
insert into designation values(100,'SM','MANAGER');

insert into place values(1,'Chennai','Offshore');
insert into place values(2,'Bangalore','Offshore');
insert into place values(3,'Hyderabad','Offshore');
insert into place values(4,'Mexico','Nearshore');
insert into place values(5,'Newyork','Onshore');
insert into place values(10,'Canada','Onshore');


insert into project values(1,'Cigna');
insert into project values(2,'ASG');
insert into project values(3,'Pepsi');
insert into project values(4,'Microsoft');
insert into project values(5,'Amazon');
insert into project values(10,'Flipkart');

select * from employee;
select * from designation;
select * from place;
select * from project;

#1)
select * from (select e.emp_id,e.emp_name,case when d.desc_name is null then 'Unknown Designation'
								when d.desc_name is not null and d.role_type is null then 'Team Lead'
                                else d.desc_name end as desc_name,
							case when p.place_desc is null then 'Others'
								when p.place_desc is not null and p.place_desc='Newyork' then 'USA' 
                                else p.place_desc
                                end as place_desc ,
							case when d.desc_name is null and pr.proj_name is null then 'Unknown Project'
                            else pr.proj_name end as "Project_name" from employee e 
left join designation d on e.desc_id=d.desc_id 
left join place p on e.place_id=p.place_id 
left join project pr on e.proj_id=pr.proj_id) as A order by A.emp_id;

#2)
SELECT e.EMP_ID,e.EMP_NAME,CASE WHEN d.ROLE_TYPE = 'DEVELOPER' and p.PLACE_TYPE ='OFFSHORE'
								then 'TEAMMEMBER'
							 WHEN d.ROLE_TYPE = 'DEVELOPER' and p.PLACE_TYPE ='NEARSHORE'
								then 'TEAMLEAD'
                             WHEN d.ROLE_TYPE = 'DEVELOPER' and p.PLACE_TYPE ='ONSHORE'
								then 'BA'
							 WHEN d.ROLE_TYPE = 'LEAD' and p.PLACE_TYPE ='ONSHORE'
								then 'SCRUMMASTER'
							 WHEN d.ROLE_TYPE is  null and p.PLACE_TYPE is not null
								then 'CONTRACTER' else 'SHADOW' end as 'PROJECT_ROLE'  from Employee as e left  join Designation as d 
on e.DESC_ID=d.DESC_ID left join Place as p on e.PLACE_ID=p.PLACE_ID  left join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID;
 


#3)

select 
CASE WHEN d.ROLE_TYPE='DEVELOPER' THEN D.ROLE_TYPE ELSE 'OTHERS' END AS DERV_ROLE_TYP,
CASE WHEN d.ROLE_TYPE ='DEVELOPER'  THEN p.PLACE_DESC ELSE 'OTHERS' END AS DERV_PLACE_DESC ,
CASE WHEN d.ROLE_TYPE='DEVELOPER' THEN pr.PROJ_NAME ELSE 'OTHERS'  END AS DERV_PROJ_DESC,
count(e.emp_id) from Employee as e 
left  join Designation as d 
on e.DESC_ID=d.DESC_ID
left  join Place as p
on e.PLACE_ID=p.PLACE_ID  
left  join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID 
 group by DERV_ROLE_TYP,DERV_PLACE_DESC,DERV_PROJ_DESC ;

#4)

select 
CASE WHEN d.ROLE_TYPE='DEVELOPER' THEN D.ROLE_TYPE ELSE 'OTHERS' END AS DERV_ROLE_TYP,
CASE WHEN d.ROLE_TYPE ='DEVELOPER'  THEN p.PLACE_DESC ELSE 'OTHERS' END AS DERV_PLACE_DESC ,
CASE WHEN d.ROLE_TYPE='DEVELOPER' THEN pr.PROJ_NAME ELSE 'OTHERS'  END AS DERV_PROJ_DESC,
count(e.emp_id) from Employee as e 
left  join Designation as d 
on e.DESC_ID=d.DESC_ID
left  join Place as p
on e.PLACE_ID=p.PLACE_ID  
left  join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID 
 group by DERV_ROLE_TYP,DERV_PLACE_DESC,DERV_PROJ_DESC ;

#13)
select substr(emp_name,3,length(emp_name)-2) as Employee_name from employee;

#15)
select emp_name from employee where emp_name like '%a%'or emp_name like '%u%' or emp_name like '%r%';
select emp_name from employee where emp_name like any ('a','u','r');