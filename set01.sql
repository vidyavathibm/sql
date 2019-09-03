AUTHOR_ID	AUTHOR_NAME	AUTHOR_COUNTRY	AUTHOR_CITY	PUBLISH_ID
PUBLISH_ID	PUBLISH_NAME	PUBLISH_CITY	PUBLISH_START_DATE	BRANCHES
use empassign;
create table author(AUTHOR_ID varchar(50) primary key,AUTHOR_NAME varchar(50),AUTHOR_COUNTRY varchar(50),
AUTHOR_CITY varchar(50),PUBLISH_ID  varchar(50) references publish(PUBLISH_ID));
create table publish(PUBLISH_ID	varchar(50) primary key,PUBLISH_NAME varchar(50) ,PUBLISH_CITY	varchar(50),
PUBLISH_START_DATE date,BRANCHES int);

insert into author values('AUT001','William Norton','UK','Cambridge','PB01');
insert into author values('AUT002','C. J. Wilde','USA','San Francisco','PB04');
insert into author values('AUT003','John Betjeman Hunter','RUSSIA','Moscow','PB01');
insert into author values('AUT004','John Betjeman Hunter','CANADA','Toronto','PB03');
insert into author values('AUT005','S.B.Swaminathan','INDIA','Delhi','PB01');
insert into author values('AUT006','Butler Andre','UK ','London','PB03');
insert into author values('AUT007','E. Howard','EUROPE','Berlin','PB03');
insert into author values('AUT008','Andrew Jeff','GERMANY','Berlin','PB02');
insert into author values('AUT009','Drek Tailor','Australia','Melbourne','PB01');
insert into author values('AUT010','Mary Coffing','US','New Jersy','PB04');
insert into author values('AUT011','Mary Coffing','US','New Jersy','PB05');

insert into publish values('PB01','Jex Max Publication','Berlin',STR_TO_DATE('4/21/1919', '%m/%d/%Y'),10);
insert into publish values('PB02','Summer Night Publication','Canada',STR_TO_DATE('8/31/2019', '%m/%d/%Y'),25);
insert into publish values('PB03','Novel Publisher Ltd.','London',STR_TO_DATE('8/10/2018', '%m/%d/%Y'),11);
insert into publish values('PB04','Mark Book Sales','New Jersy',STR_TO_DATE('5/24/2008', '%m/%d/%Y'),9);
delete from publish where PUBLISH_CITY is null;
select * from author;
select * from publish;

-- 1	Fetch publisher information who have publish_city <> author_city and check if publish_city = author_country . 
-- display the correct publisher_city along with other publisher information based on author_city
-- AUTHOR_ID, AUTHOR_NAME, AUTHOR_COUNTRY, AUTHOR_CITY, PUBLISH_ID
-- PUBLISH_ID, PUBLISH_NAME, PUBLISH_CITY, PUBLISH_START_DATE, BRANCHES

select p.PUBLISH_ID, p.PUBLISH_NAME, p.PUBLISH_CITY, p.PUBLISH_START_DATE, p.BRANCHES,a.AUTHOR_CITY 
from publish p inner join author a on  p.PUBLISH_CITY<>a.AUTHOR_CITY 
and p.PUBLISH_CITY=AUTHOR_COUNTRY;

-- 2	Fetch authors_name, author_country, publish_city, publish_start_date, branches who have publications 
-- with most number of branches by century

select * from (select  a.AUTHOR_NAME,p.PUBLISH_CITY,p.PUBLISH_START_DATE,p.BRANCHES,round(year(publish_start_date)/100), 
dense_rank() over (partition by round(year(publish_start_date)/100) order by p.branches desc) as r from author a 
inner join publish p on a.PUBLISH_ID=p.PUBLISH_ID) as A where r=1;

select * from (select  a.AUTHOR_NAME,p.PUBLISH_CITY,p.PUBLISH_START_DATE,p.BRANCHES,round(year(publish_start_date)/100), 
dense_rank() over (partition by substr(year(publish_start_date),1,2) order by p.branches desc) as r from author a 
inner join publish p on a.PUBLISH_ID=p.PUBLISH_ID) as A where r=1;

select round(year(publish_start_date)/100) from publish;

-- 3	Fetch publisher details who have authors in same city and get corresponding author details who belong 
-- to same country
select distinct A.AUTHOR_ID, A.AUTHOR_NAME, A.AUTHOR_COUNTRY, A.AUTHOR_CITY,
 A.PUBLISH_ID, A.PUBLISH_NAME, A.PUBLISH_CITY, A.PUBLISH_START_DATE, A.BRANCHES from(select a.AUTHOR_ID, a.AUTHOR_NAME, a.AUTHOR_COUNTRY, a.AUTHOR_CITY,
 a.PUBLISH_ID, p.PUBLISH_NAME, p.PUBLISH_CITY, p.PUBLISH_START_DATE, p.BRANCHES from publish p
 inner join author a on  a.AUTHOR_CITY=p.PUBLISH_CITY) as A inner join author au on A.AUTHOR_CITY=au.AUTHOR_CITY;

-- 4 Fetch authors who have incorrect author_country for same author_city. Display correct author_country along
-- with all author_information

-- 5	Fetch authors who do not have publisher from their country
 select  AUTHOR_NAME from author a 
 left join publish p on a.author_city=p.publish_city or a.author_country=p.publish_city and p.publish_name is null;
 
 select  AUTHOR_NAME from author a 
 left join publish p on a.author_city=p.publish_city or a.author_country=p.publish_city and p.publish_city is null;
 
-- 6	Fetch author details if first character of publisher name is same as author_name
select A.AUTHOR_ID, A.AUTHOR_NAME, A.AUTHOR_COUNTRY, A.AUTHOR_CITY, A.PUBLISH_ID from 
(select a.AUTHOR_ID, a.AUTHOR_NAME, a.AUTHOR_COUNTRY, a.AUTHOR_CITY, a.PUBLISH_ID,left(author_name,1) as A ,left(publish_name,1) as B from publish p
 left join author a on p.publish_id=a.publish_id) as A where A=B;
 
select substr(publish_name,1,1) as name from publish p inner join author a on a.publish_id=p.publish_id where name
like any (select (substr(author_name,1,1)) from author a);
 
-- 7	Fetch author details who have more than one initial before their name
select AUTHOR_ID, AUTHOR_NAME, AUTHOR_COUNTRY, AUTHOR_CITY, PUBLISH_ID from author a where author_name like '_._.%';

-- 8	Fetch author details who do not have initial in their name

select B.AUTHOR_ID, B.AUTHOR_NAME, B.AUTHOR_COUNTRY, B.AUTHOR_CITY, B.PUBLISH_ID from 
(select AUTHOR_ID, AUTHOR_NAME, AUTHOR_COUNTRY, AUTHOR_CITY, PUBLISH_ID,instr(author_name,'.') as A  from author ) 
B where A=0;

select * from author where author_name not like '%.%' ;

-- 9	Fetch author details who have lower case in author_country

select * from author where author_country regexp '[a-z]';

select * from author where ascii(upper(substr(author_country,2)))!=ascii(substr(author_country,2));

select * from author where ascii(lower(substr(author_country,2)))=ascii(substr(author_country,2));

select * from author where lower(substr(author_country,2)) like binary substr(author_country,2);


-- 10	Fetch author information and publisher information who have publisher with recent publish_start_date.

select * from (select a.AUTHOR_ID, a.AUTHOR_NAME, a.AUTHOR_COUNTRY, a.AUTHOR_CITY,p.PUBLISH_ID, p.PUBLISH_NAME, PUBLISH_CITY, 
PUBLISH_START_DATE, BRANCHES from author a inner join publish p on 
a.publish_id=p.publish_id)as A where publish_start_date in (select max(p.publish_start_date) from publish p);

-- 11	Fetch count of authors belong to same continent(eg. Berlin -> Europe)