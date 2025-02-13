select * from actor;
-- Write a SQL query to find when the movie 'American Beauty' released. Return movie release year.

select * from movie;

select mov_year, mov_title from movie where mov_title = 'American Beauty';

-- Write a SQL query to find those movies, which were released before 1998. Return movie title.

select mov_title from movie where mov_year<1998;

-- Write a query where it should contain all the data of the movies which were
-- released after 1995 and their movie duration was greater than 120.
select * from movie;
select * from movie where mov_year>1998 and mov_time >120;

-- Write a query to determine the Top 7 movies which were released in United
-- Kingdom. Sort the data in ascending order of the movie year.

select mov_title from movie where mov_rel_country = 'UK' order by mov_year limit 7 ;

-- Set the language of movie language as 'Chinese' for the movie which has its 
-- existing language as Japanese and the movie year was 2001.

update movie set mov_lang='Chinese' where mov_lang='Japanese';

-- Write a SQL query to find name of all the reviewers who rated the movie
-- 'Slumdog Millionaire'.

select * from reviewer;


select reviewer.rev_name
from reviewer
join movie on reviewer.rev_id = movie.mov_id
where movie.mov_title = 'American Beauty';


-- Write a query which fetch the first name, last name & role played by the
-- actor where output should all exclude Male actors.

select * from actor;
select * from cast;

select actor.act_fname, actor.act_gender,actor.act_lname, cast.role
from actor
join cast on actor.act_id = cast.act_id
where actor.act_gender != 'M';

-- Write a SQL query to find the actors who played a role in the movie 'Annie Hall'.
-- Fetch all the fields of actor table. (Hint: Use the IN operator).

SELECT * 
FROM actor
WHERE act_id IN (
    SELECT act_id
    FROM movie
    WHERE mov_title = 'Annie Hall'
);


select * from actor;
select * from movie;

-- Write a SQL query to find those movies that have been released in countries other
-- than the United Kingdom. Return movie title, movie year, movie time, and date of
-- release, releasing country.

select mov_title, mov_year, mov_time, mov_dt_rel, mov_rel_country from movie
where mov_rel_country != 'UK';

-- Print genre title, maximum movie duration and the count the number of
-- movies in each genre. (HINT: By using inner join)

select * from genres;
select * from movie;

-- Create a view which should contain the first name, last name, title of the
-- movie & role played by particular actor.

select * from movie;
select * from cast;
select * from actor;

CREATE VIEW actor_movie_role AS
SELECT a.act_fname, a.act_lname, m.mov_title AS movie_title, c.role
FROM actor a
INNER JOIN cast c ON a.act_id = c.act_id
INNER JOIN movie m ON c.mov_id = m.mov_id;

select * from actor_movie_role ;

-- Write a SQL query to find the movies with the lowest ratings

select * from movie;
select * from ratings;

SELECT m.mov_title, r.rev_stars
FROM movie m
INNER JOIN ratings r ON m.mov_id = r.mov_id
ORDER BY r.rev_stars ASC
LIMIT 1;
