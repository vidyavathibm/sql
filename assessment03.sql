#1
select A.*,count(desc_name) over(partition by desc_name) as emp_desc_cnt, count(place_desc) over(partition by place_desc) as emp_place_cnt from (select e.emp_id,e.emp_name,case when d.desc_name is null then 'Others'
                                else d.desc_name end as desc_name,
							case when p.place_desc is null then 'Others'
                                else p.place_desc
                                end as place_desc from employee e 
left join designation d on e.desc_id=d.desc_id 
left join place p on e.place_id=p.place_id 
left join project pr on e.proj_id=pr.proj_id) as A order by A.emp_id;

#2
select e.EMP_ID,e.EMP_NAME,d.DESC_NAME,p.PLACE_DESC,pr.PROJ_NAME from employee e 
left join designation d on e.desc_id=d.desc_id 
left join place p on e.place_id=p.place_id 
left join project pr on e.proj_id=pr.proj_id where pr.PROJ_NAME like '%DATA%' or pr.PROJ_NAME like '%CLOUD%';

#3)
select A.EMP_ID,A.EMP_NAME,A.desc_id,A.DESC_NAME,A.PLACE_DESC,A.PROJ_NAME from
(select e.EMP_ID,e.EMP_NAME,d.desc_id,d.DESC_NAME,p.PLACE_DESC,pr.PROJ_NAME,dense_rank() over
 (partition by p.place_id order by d.desc_id desc,pr.Proj_id) as grade
from employee e 
inner join designation d on e.desc_id=d.desc_id 
inner join place p on e.place_id=p.place_id 
inner join project pr on e.proj_id=pr.proj_id) as A where grade=1;

#4)
select * from( select distinct s2.Salesman_name as Sales_Manager,dense_rank()
 over(partition by s2.Salesman_name order by c.Purchased_amount desc) as d,c.Cust_name from Salesman s1 
 inner join Salesman s2 on s1.Sales_Manager_id=s2.Salesman_id 
 inner join Customer c on s1.Salesman_id=c.Salesman_id) as A where d=1;
 
 
 #5) 
 update Salesman s inner join(select c.Salesman_id,sum(Purchased_amount)
 as sum from customer c group by c.salesman_id) as a on s.salesman_id=a.salesman_id 
 set monthly_target=sum;