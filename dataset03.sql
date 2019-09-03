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
