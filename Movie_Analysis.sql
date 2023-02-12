use project;
SET sql_mode = 'ONLY_FULL_GROUP_BY';

#1 Top 10 IMDB movies
select Series_Title, Genre, IMDB_Rating
from IMDB
order by 3 desc
limit 10;

#2 what is the genre with the most movies?
select Genre, avg(IMDB_Rating) as average_IMDB, avg(Meta_score) as average_Meta, count(*) as num_movies
from IMDB
group by 1
order by 4 desc
limit 10;

#3 What is the director produced the most movie?
select Director, count(Series_Title) as num_movie
from IMDB
group by 1
order by 2 desc;

#4 What is star 1 acted the most movie?
select Star1, count(Series_Title) as num_movie
from IMDB
group by 1
order by 2 desc;

-- combine IMDB and Amazon Prime tables --
# 1. What is the director from IMDB produced the most movie in Amazon Prime? : David Fincher
select i.Director, count(*) as num_movies
from IMDB i
inner join amazon_prime a
on i.Series_Title = a.title
group by 1
order by 2 desc
limit 1;

# 2. What is the star 1 from IMDB acted the most movie in Amazon Prime? - Humphrey Bogart
select Star1, count(*) as num_movies
from IMDB i
inner join amazon_prime a
on i.Series_Title = a.title
group by 1
order by 2 desc
limit 1;

# 3. What is the star 2 from IMDB acted the most movie in Amazon Prime? - Audrey Hepburn
select Star2, count(*) as num_movies
from IMDB i
inner join amazon_prime a
on i.Series_Title = a.title
group by 1
order by 2 desc
limit 1;

# 4. What is the top IMDB rating movie that also added in Amazon Prime? - It's a Wonderful Life(IMDB 8.6)
select Series_Title, IMDB_Rating
from IMDB i
inner join amazon_prime a
on i.Series_Title = a.title
order by 2 desc
limit 1;

	#which channel does it have? - only one channel: Prime Video
    select Netflix, Hulu, `Prime Video`, `Disney+`
    from Movies
    where Title = (select Series_Title
	from IMDB i
	inner join amazon_prime a
	on i.Series_Title = a.title
	order by IMDB_Rating desc
	limit 1);

# 5. What is the top Meta score movie that also added in Amazon Prime? - The Lady Vanishes(98)
select Series_Title, Meta_score
from IMDB i
inner join amazon_prime a
on i.Series_Title = a.title
order by 2 desc
limit 1;

	#which channels does it provide? - only 1: prime video
	select Netflix, Hulu, `Prime Video`, `Disney+`
	from Movies
	where Title = (select Series_Title 
	from IMDB i
	inner join amazon_prime a
	on i.Series_Title = a.title
	order by Meta_score desc
	limit 1);
    
-- Platforms -- 
# which platform provide the most movies? - Amazon Prime Video has the most movies
select count(Hulu)
from Movies
where Hulu = 1;

select count(Netflix)
from Movies
where Netflix = 1; #3695

select count(`Prime Video`) #4113
from Movies
where `Prime Video` = 1;

select count(`Disney+`) #922
from Movies
where `Disney+` = 1;


# what is the rating of popular movies?
select Netflix, Age, count(*) as num_movies
from Movies
where Netflix = 1 and Age != ''
group by 1, 2
order by 3 desc;

select Hulu, Age, count(*) as num_movies
from Movies
where Hulu = 1 and Age != ''
group by 1, 2
order by 3 desc;

select `Prime Video`, Age, count(*) as num_movies
from Movies
where `Prime Video` = 1 and Age != ''
group by 1, 2
order by 3 desc;

select `Prime Video`, Age, count(*) as num_movies
from Movies
where `Prime Video` = 1 and Age != ''
group by 1, 2
order by 3 desc;

select `Disney+`, Age, count(*) as num_movies
from Movies
where `Disney+` = 1 and Age != ''
group by 1, 2
order by 3 desc;

# what is the year range of each platform?
select Netflix, (max(Year) - min(Year))
from Movies
where Netflix = 1;

select Hulu, (max(Year) - min(Year))
from Movies
where Hulu = 1;

select `Prime Video`, (max(Year) - min(Year))
from Movies
where `Prime Video` = 1;

select `Disney+`, (max(Year) - min(Year))
from Movies
where `Disney+` = 1;

# What is the most popular genres on each platform?
select Genre, count(*)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Netflix = 1
group by 1
order by 2 desc;

select Genre, count(*)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Hulu = 1
group by 1
order by 2 desc;

select Genre, count(*)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where `Prime Video` = 1
group by 1
order by 2 desc;

select Genre, count(*)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where `Disney+` = 1
group by 1
order by 2 desc;

#Which channel provide top IMDB rating movie? 
select Title, IMDB_Rating, `Rotten Tomatoes`, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
order by IMDB_Rating desc
limit 5;

#How many movies of top IMDB actor on each platform?
select Star1, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Star1 = (select Star1
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
order by IMDB_Rating desc
limit 1);


select Star1, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Star1 = 'Brad Pitt';

select Star1, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Star1 = 'Lin-Manuel Miranda';


select Star1, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Star1 = 'James Stewart';

select Star1, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Star1 = 'Éric Toledano';

# top directors have the most movies on each platform
select Director, count(*)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Netflix = 1 or Hulu = 1 or `Prime Video` = 1 or `Disney+` = 1
group by 1
order by 2 desc
limit 1; 

#What are movies top director have with IMDB and RT ratings?
select Director, Title, IMDB_Rating, `Rotten Tomatoes`, Netflix, Hulu, `Prime Video`, `Disney+`
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Director = (select Director
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Netflix = 1 or Hulu = 1 or `Prime Video` = 1 or `Disney+` = 1
group by 1
order by count(*) desc
limit 1);

# Average duration on each platform
select avg(Runtime)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Netflix = 1;

select avg(Runtime)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where Hulu = 1;

select avg(Runtime)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where `Prime Video` = 1;

select avg(Runtime)
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
where `Disney+` = 1;

-- Combine Movies, IMDB, and amazon prime tables -- 
select *
from Movies m
inner join IMDB i
on m.Title = i.Series_Title
inner join amazon_prime a
on i.Series_Title = a.title;
