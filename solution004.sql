/* Delete the tables if they already exist */
create database social;
use social;
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);


#1) Find the names of all students who are friends with someone named Gabriel. (1 point possible)

 select h2.name,f.id1 from friend f left join highschooler h1
 on f.id2 = h1.id  left join highschooler h2 on
 h2.id  = f.id1 where h1.name = 'Gabriel';

#2) For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade,
#and the name and grade of the student they like.
 
select h1.name ,l1.id2 ,h1.grade ,l1.id1,h2.name ,h2.grade from highschooler h1 inner join likes l1 
on l1.id2 = h1.id join highschooler h2 on l1.id1 = h2.id where  (h2.grade-h1.grade) >= 2;

#3)For every pair of students who both like each other, return the name and grade of both students. Include each pair only once,
#with the two names in alphabetical order

select name,grade from highschooler h where id in (select  l1.id1 from likes l1 join likes l2 
on l1.id2 = l2.id1  and l1.id1 = l2.id2) order by name asc ;

#4) Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades.
#Sort by grade, then by name within each grade.

select h.id,h.name , h.grade from highschooler h  left join likes l 

on l.id2 = h.id where l.id2 is null order by h.grade , h.name ;

#5) For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 

select h.name,h.grade from highschooler h where h.id in(select  l2.id2   from likes l1  
right  join likes l2 
on l2.id2  = l1.id1   where l1.id1 is  null );

#6) Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.

 select h.name,h.grade from Highschooler h where h.ID not in
(select f.ID1 from Friend f inner join Highschooler h1 on h1.ID=f.ID2 join highschooler h2 on h2.ID=f.ID1 where h2.grade<>h1.grade) 
order by h.grade ;

#8) Find the difference between the number of students in the school and the number of different first names. 

select count-first_name as diff from

(select distinct count(id) as count from highschooler) R,

(select distinct count(name) as  first_name from highschooler) S;

#9) Find the name and grade of all students who are liked by more than one other student. (1 point possible)

select h.name, count(l2.id2)  as count  from likes l1   right  join likes l2
 
on l2.id2  = l1.id1 join highschooler h  
on h.id = l2.id2 group by l2.id2 having count>1  ;

select h.name,h.grade from highschooler h where h.id in 
(select ID2 from likes where ID2=h.ID group by ID2 having count(ID2)>1);

#10) For every situation where student A likes student B, but student B likes a different student C, 
#return the names and grades of A, B, and C. (1 point possible)

select h1.name,h1.grade,h2.name ,h2.grade,h3.name,h3.grade from likes l1 join likes l2
on l1.id2 = l2.id1 and l1.id1 != l2.id2 
join highschooler h1 on l1.id1 = h1.id
join highschooler h2 on l1.id2  = h2.id
join highschooler h3 on l2.id2 = h3.id;


#11) Find those students for whom all of their friends are in different grades from themselves. 
#Return the students' names and grades.(1 point possible)

select f.id1,f.id2,h.name,h.grade,h1.grade from friend f join  highschooler h 
on h.id = f.id2 join highschooler h1 on h1.id = f.id1 
where h.grade!= h1.grade ;


#12) What is the average number of friends per student? (Your result should be just one number.)

select name,avg(total) as avg from (select h.name,count(id2) as total from highschooler h join friend f 
on h.id = f.id1 group by f.id1) r group by name;

#13)Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra,
#even though technically she is a friend of a friend.

select h.name from Highschooler as h join(select distinct b.id1 from(
select a.ID1,f1.ID1 as 'id2' from(
select f.ID1 from Highschooler h  join Friend as f on h.ID=f.ID2 where h.name='Cassandra') as a
join Highschooler h join Friend as f1 on a.ID1=f1.ID2 
where h.name='Cassandra') as b 
union 
select distinct id2 from(
select a.ID1,f1.ID1 as 'id2' from(
select f.ID1 from Highschooler h  join Friend as f on h.ID=f.ID2 where h.name='Cassandra') as a
join Highschooler h join Friend as f1 on a.ID1=f1.ID2 
where h.name='Cassandra') as b) as c on h.ID=c.ID1;

#14) Find the name and grade of the student(s) with the greatest number of friends

select h.name,h.grade,count(id2) as count  from highschooler h join friend f 
on h.id = f.id1 and h.id =  f.id1 
group by h.name,h.grade having count>3 order by count desc ;
