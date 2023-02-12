use Airbnb;

-- Cleaning Data -- 
#1a. How many observations do we have?
select count(*)
from booking;

#1b. How many distinct users do we have?
select count(distinct uid)
from booking;

#1c. Do we have duplications?
-- we don't.

#2. List all distinct ages, order by age in an ascending order. Do the ages make sense?
select distinct age
from booking
order by 1 asc; 

#2a. Out of curiosity, let’s print the all the information of the youngest person.
select * 
from booking
where age is not null
order by age asc
limit 1;

#2b. Out of curiosity, let’s print the all the information of the oldest person.
select *
from booking
where age is not null
order by age desc
limit 1;

#2c. How many users have not provided age info?
select count(*)
from booking
where age is null;

#2d. Those entries will influence our analysis. We need to take care of them. [Extension 1]

-- Iser Demographics -- 
#1. How many male and female users are there?
select gender, count(*)
from booking
where gender = 'MALE' OR gender = 'FEMALE'
group by 1;

#2.1 Calculate the average age of users for each gender.
select gender, avg(age)
from booking
group by 1;

#2.2 Calculate the average age of users for each gender, excluding users whose age is greater than 100 or less than 10.
select gender, avg(age)
from booking
where age <= 100 OR age >= 10
group by 1; 

#2.3 Do we observe a difference in there? What does it tell us?
-- No

#3. Calculate the number of user-bookings to each destination, name it as visitors. Show the countries 
# with more than 500 visitors (excluding NDF and Others).
select country_destination, count(*) as visitors
from booking
where country_destination != 'NDF' AND country_destination != 'Other'
group by 1
having count(*) > 500;

#4.1 List the top 5 most popular countries (excluding NDF and Others) among male users.
select country_destination, count(*) as visitors
from booking
where gender = 'MALE' AND (country_destination != 'NDF' AND country_destination != 'Other')
group by 1
order by 2 desc
limit 5;

#4.2 List the top 5 most popular countries (excluding NDF and Others) among female users.
select country_destination, count(*) as visitors
from booking
where gender = 'FEMALE' AND (country_destination != 'NDF' AND country_destination != 'Other')
group by 1
order by 2 desc
limit 5;

#4.3 Is there a difference between the two lists?
-- more female went to IT than male did. also ES and GB are more popular for male visitors. 

#5. How many people make the booking through a phone? A desktop? An apple product?
select first_device_type, count(*)
from booking
where first_device_type REGEXP 'Phone|iPad|Desktop'
group by 1;

-- Time Difference --
#1.1 In this dataset, which user created his/her account earliest? 
select uid
from booking
order by date_account_created desc
limit 1;

#1.2 Who created the account latest?
select uid
from booking
order by date_account_created asc
limit 1;

#2. How many users make booking decision the same day as they create their account?
select count(*)
from booking
where date_first_booking = date_account_created;

#3. How many users create the account in the same month as the first booking? 
select count(*)
from booking
where month(date_account_created) = month(date_first_booking) and year(date_account_created)=year(date_first_booking);


#4. Calculate the difference in days between “account creation” and “first booking”, name it as “dategap”.
select *, datediff(date_first_booking, date_account_created) as dategap
from booking
where date_account_created is not null and date_first_booking is not null;

-- Extension -- 
#After observing anomaly for user age, we decide to delete those records with unrealistic ages. Specifically, do following steps:
#i. Select only the records that satisfy following condition: 10<Age<150
#ii. Create a new table that holds the result table from previous query, name the table as “booking_new”. 

create table booking_new 
select *
from booking
where age < 150 and age > 10 and age is not null;








