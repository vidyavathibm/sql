create table trip(TRIP_ID varchar(40),TRIP_SOURCE varchar(40),TRIP_DESTINATION varchar(40),
TRIP_START_TIME time,TRIP_END_TIME time,TRIP_COST integer,DYNAMIC_FARE varchar(40));

insert into trip values('TP01','CHN','BGL','13:40','15:40',3500,'Y');
insert into trip values('TP02','BGL','MUM','18:20','19:20',6700,'Y');
insert into trip values('TP03','CHN','HYD','9:45','11:10',3000,'Y');
insert into trip values('TP04','HYD','BGL','12:20','13:25',2700,'N');
insert into trip values('TP05','MUM','NDL','23:00','1:25',4500,'Y');
insert into trip values('TP06','BGL','NDL','19:40','22:10',5000,'N');
insert into trip values('TP07','NDL','MUM','16:45','17:50',6000,'Y');
insert into trip values('TP08','MUM','BGL','20:20','23:45',5000,'N');
insert into trip values('TP09','NDL','HYD','11:25','13:45',3000,'N');
insert into trip values('TP10','HYD','CHN','20:30','22:20',4500,'Y');
insert into trip values('TP11','BGL','CHN','23:45','1:05',3900,'Y');
select * from trip;
TRIP_ID, TRIP_SOURCE, TRIP_DESTINATION, TRIP_START_TIME, TRIP_END_TIME, TRIP_COST, DYNAMIC_FARE

-- 1	Fetch itinerary details from CHN to NDL which are cheaper

select * from(select TRIP_COST,TRIP_SOURCE,TRIP_DESTINATION,dense_rank() over(partition by min(trip_cost)) as r
from trip where TRIP_SOURCE='CHN' and TRIP_DESTINATION='NDL') as A where r=1;

select *,min(trip_cost) from trip where TRIP_SOURCE='CHN' and TRIP_DESTINATION='NDL';

-- 2	Fetch itinerary details from CHN to NDL which have less travel time
 
 select case when trip_start_time>trip_end_time then timediff(TRIP_START_TIME,TRIP_END_TIME) 
when trip_start_time<trip_end_time then timediff(TRIP_END_TIME,TRIP_START_TIME) end as time from trip;

select * from trip t1 inner join trip t2 where t1.trip_destination=t2.trip_source

-- 3	Fetch itinerary details from CHN to NDL which have less dynamic pricing(assume current_date = 'Sunday')

-- 4	Fetch itinerary details from CHN to NDL which happens on same day

-- 5	Fetch itinerary details from CHN to NDL which have mimum wait time at transit

-- 6	Fetch return itinerary details from NDL to CHN with mimum transits

-- 7	Fetch itinerary details from CHN to BGL before 11 AM

-- 8	Fetch return itinerary details from NDL to CHN which happens on same day or which has less travel time
-- 9	Fetch trip details which have less travel time
-- 10	Fetch trip details which have high travel time and no dynamic pricing
