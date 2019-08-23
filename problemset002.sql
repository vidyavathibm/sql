create database garden_db; 
use garden_db;
Create table Location (locationid int primary key, name varchar(30), sunlight int, water int); 
Create table Gardener (gardenerid int primary key, name varchar(30), age int); 
Create table Plant (plantid int primary key, name varchar(30), sunlight int, water int, weight int); 
Create table planted (plantFK int, gardenerFK int, locationFK int, date1 date, seeds int, foreign key(plantFK) references plant(plantid), foreign key(gardenerFK) references gardener(gardenerid), foreign key(locationFK) references location(locationid)); 
Create table picked (plantFK int, gardenerFK int, locationFK int, date1 date, amount int, weight int, foreign key(plantFK) references plant(plantid), foreign key(gardenerFK) references gardener(gardenerid), foreign key(locationFK) references location(locationid)); 

Insert into location values(0, 'East', .28, .80); 
Insert into location values(1, 'North', .17, .84); 
Insert into location values(2, 'West', .38, .48); 
Insert into location values(3, 'South', .45, .66); 

/* Set-up for gardener Table */
Insert into gardener values(0, 'Mother' ,36); 
Insert into gardener values(1, 'Father', 38); 
Insert into gardener values(2, 'Tim', 15); 
Insert into gardener values(3, 'Erin', 12); 

/* Set-up for plant Table */
Insert into plant values(0, 'Carrot', .26, .82, .08); 
Insert into plant values(1, 'Beet', .44, .80, .04); 
Insert into plant values(2, 'Corn', .44, .76, .26); 
Insert into plant values(3, 'Tomato', .42, .80, .16); 
Insert into plant values(4, 'Radish', .28, .84, .02); 
Insert into plant values(5, 'Lettuce', .29, .85, .03); 

/* Set-up for planted Table */
Insert into planted values(0, 0, 0 , '2012-04-18', 28); 
Insert into planted values(0, 1, 1 , '2012-04-14', 14); 
Insert into planted values(1, 0, 2 , '2012-04-18', 36); 
Insert into planted values(2, 1, 3 , '2012-04-14', 20); 
Insert into planted values(2, 2, 2 , '2012-04-19', 12); 
Insert into planted values(3, 3, 3 , '2012-04-25', 38); 
Insert into planted values(4, 2, 0 , '2012-04-30', 30); 
Insert into planted values(5, 2, 0 , '2012-04-15', 30); 

/* Set-up for picked Table */
Insert into picked values(0, 2, 0 , '2012-08-18', 28, 2.32); 
Insert into picked values(0, 3, 1 , '2012-08-16', 12, 1.02); 
Insert into picked values(2, 1, 3 , '2012-08-22', 52, 12.96); 
Insert into picked values(2, 2, 2 , '2012-08-28', 18, 4.58); 
Insert into picked values(3, 3, 3 , '2012-08-22', 15, 3.84); 
Insert into picked values(4, 2, 0 , '2012-08-16', 23, 0.52); 

select * from location;
select * from gardener;
select * from plant;
select * from planted;
select * from picked;

#1)Write a valid SQL statement that calculates the total weight of all corn cobs that
# were picked from the garden:
select sum(pk.weight) from plant p inner join picked pk on p.plantid=pk.plantFK 
where p.name="Corn";

#2)For some reason Erin has change his location for picking the tomato to North. 
#Write the corresponding query.
update picked set locationid=(select p.plantid,g.gardenerid,l.locationid from plant p 
inner join picked pk on p.plantid=pk.plantFK
inner join gardener g on g.gardenerid=pk.gardenerFK 
inner join location l on l.locationid=pk.locationFK) where pk.locationmFK=3;

#3)Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores 
#Experience of the of person. How will you modify this to varchar2(30).
alter table gardener add column(Exper int (3)); 
desc gardener;
alter table gardener modify Exper varchar(30);
desc gardener;

#4)Write a query to find the plant name which required seeds less than 20 which plant 
#on 14-APR
select p.name from  plant p inner join planted pd on 
p.plantid=pd.plantFK where pd.seeds<20 and month(date1)='04' and day(date1)=14;

#5)List the amount of sunlight and water to all plants with names that start with letter 
#'c' or letter 'r'.
select name,sunlight,water from plant where name like in ['c','r'%];

#6)Write a valid SQL statement that displays the plant name and the total amount of seed 
#required for each plant that were plant in the garden. The output should be in descending order of plant name.

#7)Write a valid SQL statement that calculates the average number of items produced per seed 
#planted for each plant type:( (Average Number of Items = Total Amount Picked / Total Seeds Planted.)

#8)Write a valid SQL statement that would produce a result set like the following:

 #name |  name  |    date    | amount 
#------|--------|------------|-------- 
# Tim  | Radish | 2012-07-16 |     23 
# Tim  | Carrot | 2012-08-18 |     28 

#9)Find out persons who picked from the same location as he/she planted.

#10)Create a view that lists all the plant names picked from all locations except ’West’ in 
#the month of August.