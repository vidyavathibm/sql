create Database hotel_db;
use hotel_db;


create table hotel(hotel_No varchar(5)  primary key,Name varchar(20),City varchar(15));

insert into hotel values('H111','Empire hotel','New York');
insert into hotel values('H235','Park Place','New York');
insert into hotel values('H432','Brownstone hotel','Toronto');
insert into hotel values('H498','James Plaza','Toronto');
insert into hotel values('H193','Devon hotel','Boston');
insert into hotel values('H437','Clairmont hotel','Boston');



create table room(room_No  integer primary key,hotel_No varchar(5)  references hotel(hotel_No),RType varchar(2),Price double(5,2));

insert into room values(313,'H111','S',145.00);
insert into room values(412,'H111','N',145.00);
insert into room values(1267,'H235','N',175.00);
insert into room values(1289,'H235','N',195.00);
insert into room values(876,'H432','S',124.00);
insert into room values(898,'H432','S',124.00);
insert into room values(345,'H498','N',160.00);
insert into room values(467,'H498','N',180.00);
insert into room values(1001,'H193','S',150.00);
insert into room values(1201,'H193','N',175.00);
insert into room values(257,'H437','N',140.00);
insert into room values(223,'H437','N',155.00);


create table guest(guest_No varchar(5) primary key,Name varchar(15),City varchar(15));

insert into guest values('G256','Adam Wayne','Pittsburgh');
insert into guest values('G367','Tara Cummings','Baltimore');
insert into guest values('G879','Vanessa Parry','Pittsburgh');
insert into guest values('G230','Tom Hancock','Philadelphia');
insert into guest values('G467','Robert Swift','Atlanta');
insert into guest values('G190','Edward Cane','Baltimore');


create table booking(hotel_No varchar(5) references room(hotel_No),guest_No  varchar(5) references guest(guest_No),Date_From date,Date_To date,room_No integer references room(room_No));

insert into booking values('H111','G256','1999-08-10','1999-08-15',412);
insert into booking values('H111','G367','1999-08-18','1999-08-21',412);
insert into booking values('H235','G879','1999-09-05','1999-09-12',1267);
insert into booking values('H498','G230','1999-09-15','1999-09-18',467);
insert into booking values('H498','G256','1999-11-30','1999-12-02',345);
insert into booking values('H498','G467','1999-11-03','1999-11-05',345);
insert into booking values('H193','G190','1999-11-15','1999-11-19',1001);
insert into booking values('H193','G367','1999-09-12','1999-09-14',1001);
insert into booking values('H193','G367','1999-10-01','1999-10-06',1201);
insert into booking values('H437','G190','1999-10-04','1999-10-06',223);
insert into booking values('H437','G879','1999-09-14','1999-09-17',223);