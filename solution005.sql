    
#1) Give the organiser's name of the concert in the Assembly Rooms after the first of Feb, 1997. (1 point possible)

select m.m_name from musician m inner join concert c 
on  c.concert_no = m.m_no where concert_venue = 'Assembly Rooms' and con_date > 01/02/1997 ;

#2) Find all the performers who played guitar or violin and were born in England. (1 point possible)

select m.m_name from performer p join musician m on m.m_no  = p.perf_is 
join place pl on pl.place_no = m.born_in
where (p.instrument = 'violin' OR p.instrument = 'guitar') and (pl.place_country = 'England');

#3) List the names of musicians who have conducted concerts in USA together with the towns and dates of these concerts. 

select m.m_name ,p.place_town,p.place_country from place p join concert c 
on c.concert_in = p.place_no join musician m 
on c.concert_orgniser = m.m_no where p.place_country = 'USA';

#6) List the names, dates of birth and the instrument played of living musicians who play a instrument which Theo also plays.

select   m1.m_name,m1.born,p1.instrument from musician m1 join performer p1 on p1.perf_is = m1.m_no
where m1.died is null and instrument in
(select  p.instrument from performer p join musician  m
on p.perf_is = m.m_no where m.m_name LIKE '%Theo%');

#7) List the name and the number of players for the band whose number of players is greater than the average number of players in each band. (1 point possible)

 select band_name,count(*) from band join plays_in
     on band_no=band_id
     group by band_name
     having count(*)>
    (select avg(play) from(
     select band_id,count(*) as play from plays_in
    group by band_id) avgplay);

#8)List the names of musicians who both conduct and compose and live in Britain

select distinct m.m_name from concert c   join composer cp on cp.comp_is  = c.concert_orgniser
join musician m on m.m_no = cp.comp_is  join place p 
on p.place_no = m.living_in where p.place_country = 'England' ;

#9) Show the least commonly played instrument and the number of musicians who play it.

select * from(
select p.instrument ,count(p.instrument) as total,dense_rank() over (order by count(p.instrument) ) ra from
performer p group by p.instrument)a where ra = 1;

#10) List the bands that have played music composed by Sue Little;Give the titles of the composition in each case. (1 point possible)

select band_name,c_title as title from musician  join composer c
     on m_no=comp_is join has_composed  on comp_no=cmpr_no
     join composition on cmpn_no=c_no
     join performance on c_no=performed
     join band on gave=band_no
     where m_name='Sue Little'
     order by band_name,c_title;

#11)
select distinct m1.m_name,p1.place_town,p1.place_country from musician m1 join performer
      on m1.m_no=perf_is
      join place p1 on m1.born_in=p1.place_no
      join (select place_no,m_no from musician join place
      on born_in=place_no where m_name='James first') tbl2
      on p1.place_no=tbl2.place_no
      where m1.m_no!=tbl2.m_no;
      
      
#12)Give the band name, conductor and contact of the bands performing at the most recent concert in the Royal Albert Hall. (1 point possible)

select band_name,m.m_name contact,m1.m_name conductor from band b
      join performance p on band_no=gave
      join concert c on concert_no=performed_in
      join musician m on m.m_no=band_contact
      join musician m1 on m1.m_no=conducted_by
      where concert_venue='Royal Albert Hall';
