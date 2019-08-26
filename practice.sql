create database dummy;
use dummy;
create table tabA (colA1 int , colA2 varchar(10));
create table tabB (colB1 int, colB2 varchar(10));
insert into tabA values(11,"21");
insert into tabA values(11,"21");
insert into tabA values(12,"22");
insert into tabA values(null,"24");

insert into tabB values(11,"Twenty one");
insert into tabB values(11,"Twenty 1");
insert into tabB values(12,"twenty two");
insert into tabB values(null,"twenty fo");

select * from tabA right join tabB on colA1=colB1;
