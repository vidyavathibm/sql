create database Movie_db;
use Movie_db;
create table Movie(mID int primary key, title text, year int, director text);
create table Reviewer(rID int primary key , name text);
create table Rating(rID int references Reviewer(rID), 
mID int references Movie(mID), stars int, ratingDate date);

insert into Movie values(101, 'Gone with the Wind', 1939, 'Victor Fleming');
insert into Movie values(102, 'Star Wars', 1977, 'George Lucas');
insert into Movie values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into Movie values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into Movie values(105, 'Titanic', 1997, 'James Cameron');
insert into Movie values(106, 'Snow White', 1937, null);
insert into Movie values(107, 'Avatar', 2009, 'James Cameron');
insert into Movie values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

insert into Reviewer values(201, 'Sarah Martinez');
insert into Reviewer values(202, 'Daniel Lewis');
insert into Reviewer values(203, 'Brittany Harris');
insert into Reviewer values(204, 'Mike Anderson');
insert into Reviewer values(205, 'Chris Jackson');
insert into Reviewer values(206, 'Elizabeth Thomas');
insert into Reviewer values(207, 'James Cameron');

#insert into reviewer(name, movie title, stars, and ratingDate) values(208, 'Ashley White');

insert into Rating values(201, 101, 2, '2011-01-22');
insert into Rating values(201, 101, 4, '2011-01-27');
insert into Rating values(202, 106, 4, null);
insert into Rating values(203, 103, 2, '2011-01-20');
insert into Rating values(203, 108, 4, '2011-01-12');
insert into Rating values(203, 108, 2, '2011-01-30');
insert into Rating values(204, 101, 3, '2011-01-09');
insert into Rating values(205, 103, 3, '2011-01-27');
insert into Rating values(205, 104, 2, '2011-01-22');
insert into Rating values(205, 108, 4, null);
insert into Rating values(206, 107, 3, '2011-01-15');
insert into Rating values(206, 106, 5, '2011-01-19');
insert into Rating values(207, 107, 5, '2011-01-20');
insert into Rating values(208, 104, 3, '2011-01-02');

select * from Rating;
select * from Reviewer;
select * from Movie;

#01)Find the titles of all movies directed by Steven Spielberg. (1 point possible)
select title from movie where director="Steven Spielberg";

#02)Find all years that have a movie that received a rating of 4 or 5, and sort them 
#in increasing order. (1 point possible)
select year(ratingDate) from rating where stars in (4,5) order by stars;

#03)Find the titles of all movies that have no ratings. (1 point possible)
select m.title from movie m left join rating r on m.mid=r.mid where r.stars is null;

#04)Some reviewers didn't provide a date with their rating. Find the names of all reviewers 
#who have ratings with a NULL value for the date. (1 point possible)
select re.name from Reviewer re inner join Rating r on re.rID=r.rID where r.ratingDate is null;

#05)Write a query to return the ratings data in a more readable format: reviewer name, movie 
#title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title,
# and lastly by number of stars. (1 point possible)

Select re.name,m.title,r.stars,r.ratingDate from movie m inner join rating r on r.mID=m.mID 
inner join reviewer re on re.rID=r.rID order by re.name,m.title,r.stars;

#06)For all cases where the same reviewer rated the same movie twice and gave it a higher 
#rating the second time, return the reviewer's name and the title of the movie. (1 point possible)

Select tab.name,tab.title,tab.stars,tab.ratingDate,d from (Select re.name,m.title,r.stars,r.ratingDate,dense_rank() over 
(partition by re.name,m.title order by re.name,m.title,r.ratingDate) as d from movie m inner join rating r on r.mID=m.mID 
inner join reviewer re on re.rID=r.rID) as tab where r.stars;

#07)For each movie that has at least one rating, find the highest number of stars that movie 
#received. Return the movie title and number of stars. Sort by movie title. (1 point possible)

#08)For each movie, return the title and the 'rating spread', that is, the difference between highest and 
#lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)

#09)Find the difference between the average rating of movies released before 1980 and the average rating of movies 
#released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages
# for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)

#10)Find the names of all reviewers who rated Gone with the Wind. (1 point possible)

#11)For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. (1 point possible)

#12)Return all reviewer names and movie names together in a single list, alphabetized. 
#(Sorting by the first name of the reviewer and first word in the title is fine; no need 
#for special processing on last names or removing "The".) (1 point possible)

#13)Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)

#14)For all pairs of reviewers such that both reviewers gave a rating to the same movie, 
#return the names of both reviewers. Eliminate duplicates, don't pair reviewers with 
#themselves, and include each pair only once. For each pair, return the names in the pair 
#in alphabetical order. (1 point possible)

#15)For each rating that is the lowest (fewest stars) currently in the database, return the 
#reviewer name, movie title, and number of stars. (1 point possible)

#16)List movie titles and average ratings, from highest-rated to lowest-rated. If two or more
# movies have the same average rating, list them in alphabetical order. (1 point possible)

#17)Find the names of all reviewers who have contributed three or more ratings. (As an extra
# challenge, try writing the query without HAVING or without COUNT.) (1 point possible)

#18)Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)

#19)Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

#20)Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
#(Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding
#the lowest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

#21)For each director, return the director's name together with the title(s) of the movie(s) they directed that 
#received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director 
#is NULL. (1 point possible)
