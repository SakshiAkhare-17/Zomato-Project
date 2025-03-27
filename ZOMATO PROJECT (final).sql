create database Zomato_Sales_Analysis;
use Zomato_Sales_Analysis;
select* from abc;
select* from country;
select* from currency;
select count('restaurant name') from abc;

/* 1. Find the Numbers of Resturants based on City and Country*/

select city, count(restaurantid)from abc
group by city;
select countryname, count(restaurantid) from abc a
left join country c on a.countrycode = c.countryid
group by countryname;

select a.city, count(a.restaurantid)as city_count, c.countryname
from abc a 
left join country c on a.countrycode = c.countryid
group by a.city, c.countryname;

/* 2.Numbers of Resturants opening based on Year , Quarter , Month*/

  /*-----------------------TOTAL RESTAURANTS OPEN YEARWISE----------------------------*/

SELECT distinct year(year) as year, count(*)
from abc
group by year(year);

select distinct monthname(year) as month_name, count(*)
from abc
group by monthname(year);

SELECT quarter, count(*) AS Restaurantcount
from abc
where quarter is not null
group by quarter
order by Quarter;


/* 3.Percentage of Resturants based on "Has_Table_booking"*/

select
Has_Table_booking,
count(*) AS TotalRestaurants,
round((COUNT(*) / (SELECT COUNT(*) FROM abc )) *100,2) as percentage
from
abc
group by 
Has_Table_booking;

/* 4. Percentage of Resturants based on "Has_Online_delivery"*/

select
Has_online_delivery,
count(*) AS TotalRestaurants,
round((COUNT(*) / (SELECT COUNT(*) FROM abc )) *100,2) as percentage
from
abc
group by 
Has_online_delivery;

/* 5. Count of Resturants based on Ratings*/

select
Rating as IndividualRating,
count(*) as RestaurantCount
from abc
where Rating is not null
group by Rating
order by Rating asc;

/* 6. FIND TOTAL Cusines*/

Select Cuisines, count(Cuisines) from abc
group by Cuisines;

/* 7. FIND COST BUCKET LIST AND RESTAURANT COMES UNDER BUCKET*/

select 
cost_range,
count(*) as TotalRestaurants
from(
select
case
when Average_cost_for_two between 0 and 300 then '0-300'
when Average_cost_for_two between 301 and 600 then '301-600'
when Average_cost_for_two between 601 and 1000 then '601-1000'
when Average_cost_for_two between 1001 and 430000 then '1001-430000'
else 'other'
end as Cost_range
from abc
) as Subquery
group by Cost_Range;
