-- create table walmart (
-- invoice_id int primary key,
-- Branch	varchar(40),
-- City	varchar(50),
-- category varchar(40),	
-- unit_price	decimal(10,2),
-- quantity tinyint,
-- date date,
-- time time,
-- payment_method	varchar(30),
-- rating	decimal(10,2),
-- profit_margin	decimal(10,2),
-- total decimal(10,2)
-- )


select sum(total) as total_revenue
from walmart;

select distinct payment_method
from walmart;

select payment_method , count(*) as count
from walmart
group by payment_method
order by 2 desc;

select  count(distinct Branch) from walmart;

select branch , count(*) as total_sales, sum(total) as total_revenue
from walmart
group by branch
order by 2 desc,3 desc
limit 10;

select city , count(*) as total_sales, sum(total) as total_revenue
from walmart
group by city
order by 2 desc,3 desc
limit 10;


select monthname(date) as month, count(*) as total_sales, sum(total) as total_revenue
from walmart
group by monthname(date)
order by 2 desc, 3 desc ;




select * from walmart;

select category, sum(quantity) as quantity_sold ,round(avg(profit_margin),2) as avg_profit_margin
from walmart
group by 1
order by 2 desc, 3 desc;


--  real world business problem

--  1. Analyze Payment Methods and Sales
--  ● Question: What are the different payment methods, and how many transactions and
--  items were sold with each method?
--  ● Purpose: This helps understand customer preferences for payment methods, aiding in
--  payment optimization strategies.


select 
	  payment_method , 
      count(*) as total_transaction, 
      sum(quantity) as total_quantity
from walmart
group by payment_method
order by 2 desc , 3 desc;


--  2. Identify the Highest-Rated Category in Each Branch
--  ● Question: Which category received the highest average rating in each branch?
--  ● Purpose: This allows Walmart to recognize and promote popular categories in specific
--  branches, enhancing customer satisfaction and branch-specific marketing.

select * from(
select 
	  branch, 
      category, 
      avg(rating) as avg_rating,
      dense_rank() over(partition by branch order by avg(rating) desc) as ranking
from walmart
group by 1,2
order by 1, 3 desc) as t1
where ranking =1;


--  3. Determine the Busiest Day for Each Branch
--  ● Question: What is the busiest day of the week for each branch based on transaction
--  volume?
--  ● Purpose: This insight helps in optimizing staffing and inventory management to
--  accommodate peak days.

select * from(
select 
     branch, 
     dayname(date_format(date, '%d-%m-%y')) AS day_name,
     count(*) as no_of_transaction,
     rank() over(partition by branch order by count(*) desc) as rn
from walmart
group by 1,2
order by 1, 3 desc) as t1
where rn = 1;

-- 4. Calculate Total Quantity Sold by Payment Method
--  ● Question: How many items were sold through each payment method?
--  ● Purpose: This helps Walmart track sales volume by payment type, providing insights
--  into customer purchasing habits.

select 
	  payment_method , 
      sum(quantity) as total_quantity
from walmart
group by payment_method
order by 2 desc;

--  5. Analyze Category Ratings by City
--  ● Question: What are the average, minimum, and maximum ratings for each category in
--  each city?
--  ● Purpose: This data can guide city-level promotions, allowing Walmart to address
--  regional preferences and improve customer experiences

select 
     city, 
     category,
     round(avg(rating),2) as avg_rating, 
     min(rating) as min_rating,
     max(rating) as max_rating
from walmart
group by 1,2
order by 3 desc;

select * from walmart;

