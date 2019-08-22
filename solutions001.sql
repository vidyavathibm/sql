select * from guest;
select * from booking;
select * from hotel;
select * from room;

#1.List full details of all hotels.
select t2.hotel_no,t2.name,t2.city,t2.room_no,t2.rtype,t2.price,t2.guest_no,t2.date_from,t2.date_to,g.name,g.city
from (select t1.hotel_no,t1.name,t1.city,t1.room_no,t1.rtype,t1.price,b.guest_no,b.date_from,b.date_to
from (select h.hotel_no,h.name,h.city,r.room_no,r.rtype,r.price from hotel h 
left join room r on h.hotel_no=r.hotel_no) t1 
left join booking b on t1.hotel_no=b.hotel_no and t1.room_no=b.room_no) t2 
left join guest g on t2.guest_no=g.guest_no;

#2.List full details of all hotels in New York.
select t2.hotel_no,t2.name,t2.city,t2.room_no,t2.rtype,t2.price,t2.guest_no,t2.date_from,t2.date_to,g.name,g.city
from (select t1.hotel_no,t1.name,t1.city,t1.room_no,t1.rtype,t1.price,b.guest_no,b.date_from,b.date_to
from (select h.hotel_no,h.name,h.city,r.room_no,r.rtype,r.price from hotel h 
left join room r on h.hotel_no=r.hotel_no where h.city="New York") t1 
left join booking b on t1.hotel_no=b.hotel_no and t1.room_no=b.room_no) t2 
left join guest g on t2.guest_no=g.guest_no;

#3.List the names and cities of all guests, ordered according to their cities.
select name,city from guest order by city;

#4.List all details for non-smoking rooms in ascending order of price.
select * from hotel h inner join room r on h.hotel_no=r.hotel_no where r.rtype='N';

#5.List the number of hotels there are.
select count(hotel_no) No_of_Hotels from hotel;

#6.List the cities in which guests live. Each city should be listed only once.
select  distinct city from guest ;

#7.List the average price of a room.
select avg(price) from room;

#8.List hotel names, their room numbers, and the type of that room.
select h.name as Hotel_name,r.room_no,r.rtype from hotel h inner join room r on h.hotel_No=r.hotel_No;

#9.List the hotel names, booking dates, and room numbers for all hotels in New York.
select h.name as Hotel_name,b.room_no,b.Date_From,b.Date_To from booking b 
inner join hotel h on b.hotel_No=h.hotel_No;

#10.What is the number of bookings that started in the month of September?
select count(*) as bookings_in_september from booking where month(Date_From)=9;

#11.List the names and cities of guests who began a stay in New York in August.
select g.name,g.city from  guest as g 
inner join booking as b on g.guest_No=b.guest_No 
inner join hotel as h on b.hotel_No=h.hotel_No where month(Date_From)=8 and h.city='New York'; 

#12.List the hotel names and room numbers of any hotel rooms that have not been booked.
select  h.name,r.hotel_no,r.room_No from room r 
left join booking b on r.room_No=b.room_No 
inner join hotel h on h.hotel_no=r.hotel_no where b.room_No is null;

#13.List the hotel name and city of the hotel with the highest priced room.
select h.name,h.city,a.price from  (
select hotel_no,price,dense_rank() over (order by price desc) as price_rank from room) as a inner join hotel h 
on a.hotel_No=h.hotel_No where price_rank =1;

#14.List hotel names, room numbers, cities, and prices for hotels that have rooms with prices 
#lower than the lowest priced room in a Boston hotel.
select h.name,r.room_No,h.city,r.price from room as r 
inner join hotel as h on r.hotel_No=h.hotel_No where r.price <
(select min(r.price) from room as r inner join hotel as h on r.hotel_No=h.hotel_No 
where h.name='Brownstone hotel');

#15.List the average price of a room grouped by city.
select avg(r.price) average_price_of_a_room from room r left join hotel h on r.hotel_No=h.hotel_No 
group by h.city;
