create table stats(Stats_ID int,month int,YEAR int,TEMP_FARENHEIT float(50,2),RAIN_INCH float(50,2));

insert into stats values(13,1,2010,57.4,0.31);
insert into stats values(13,5,2010,91.7,5.15);
insert into stats values(13,12,2010,12.6,8.34);
insert into stats values(13,9,2010,100.3,10.34);
insert into stats values(44,9,2010,27.2,3.45);
insert into stats values(44,2,2010,27.3,0.18);
insert into stats values(44,6,2010,74.8,2.11);
insert into stats values(66,3,2010,6.7,2.1);
insert into stats values(66,7,2010,65.8,4.52);

create table station(Station_ID int,CITY varchar(50),STATE varchar(50),LAT_N int,LONG_W int);
insert into station values(13,'Phoenix','AZ',33,112);
insert into station values(44,'Denver','CO',40,105);
insert into station values(66,'Caribou','ME',47,68);

select * from (select *,dense_rank() over (partition by city order by temp_farenheit desc,rain_inch desc) 
as rnk from station st inner join stats s on st.Station_ID=Stats_ID group by month) as A where rnk=1;

select st.Station_ID,st.CITY,st.STATE,s.month,s.year,(s.TEMP_FARENHEIT-32)*5/9 as TEMP_CELSIUS,
(s.RAIN_INCH*03937) as RAIN_FALL
from station st inner join stats s on st.Station_ID=Stats_ID;

select case when d=1 and Quarters in ("Q1","Q2","Q3","Q4") then 1

(select *,case when month in (1,2,3) then "Q1"
		    when month in (4,5,6) then "Q2"
            when month in (7,8,9) then "Q3"
            when month in (10,11,12) then "Q4" else null end as Quarters,dense_rank() over ( order by state) as d
            from station st left join stats s on st.Station_ID=Stats_ID);
