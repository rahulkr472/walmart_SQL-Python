# walmart_SQL-Python


Walmart Business Problems 


1. Analyze Payment Methods and Sales
  ● Question: What are the different payment methods, and how many transactions and items were sold with each method?
  ● Purpose: This helps understand customer preferences for payment methods, aiding in payment optimization strategies.

```sq
select 
	  payment_method , 
      count(*) as total_transaction, 
      sum(quantity) as total_quantity
from walmart
group by payment_method
order by 2 desc , 3 desc;
```

2. Identify the Highest-Rated Category in Each Branch
   ● Question: Which category received the highest average rating in each branch?
   ● Purpose: This allows Walmart to recognize and promote popular categories in specific branches, enhancing customer satisfaction and branch-specific marketing.

```sq
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
```

3. Determine the Busiest Day for Each Branch
  ● Question: What is the busiest day of the week for each branch based on transaction volume?
  ● Purpose: This insight helps in optimizing staffing and inventory management to accommodate peak days.

```sq
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
```

4. Calculate Total Quantity Sold by Payment Method
  ● Question: How many items were sold through each payment method?
  ● Purpose: This helps Walmart track sales volume by payment type, providing insights into customer purchasing habits.

```sq
select 
	  payment_method , 
      sum(quantity) as total_quantity
from walmart
group by payment_method
order by 2 desc;
```

5. Analyze Category Ratings by City
  ● Question: What are the average, minimum, and maximum ratings for each category in each city?
  ● Purpose: This data can guide city-level promotions, allowing Walmart to address regional preferences and improve customer experiences

```sq
select 
     city, 
     category,
     round(avg(rating),2) as avg_rating, 
     min(rating) as min_rating,
     max(rating) as max_rating
from walmart
group by 1,2
order by 3 desc;
```

6. Calculate Total Profit by Category
  ● Question: What is the total profit for each category, ranked from highest to lowest?
  ● Purpose: Identifying high-profit categories helps focus efforts on expanding these products or managing pricing strategies effectively.

```sq
select 
     category, 
     sum(total) as total_revenue , 
     round(sum(total * profit_margin),2) as profit 
from walmart
group by category
order by 3 desc;
```

7. Determine the Most Common Payment Method per Branch
  ● Question: What is the most frequently used payment method in each branch?
  ● Purpose: This information aids in understanding branch-specific payment preferences, potentially allowing branches to streamline their payment processing systems.

```sq
with cte as
(select 
	 branch,
     payment_method,
     count(*) as no_transaction,
     rank() over(partition by branch order by count(*) desc) as rn
from walmart
group by 1,2
order by branch)
select 
     branch,
     payment_method,
     no_transaction
from cte
where rn = 1;
```

8. Analyze Sales Shifts Throughout the Day
  ● Question: How many transactions occur in each shift (Morning, Afternoon, Evening) across branches?
  ● Purpose: This insight helps in managing staff shifts and stock replenishment schedules, especially during high-sales periods.

```sq
select 
	  branch, 
      case when hour(time) < 12 then "Morning"
           when  hour(time) between 12 and 17 then "Afternoon"
           else "Evening"
	  end as shift,
      count(*) total_transaction
from walmart
group by 1, 2
order by 1, 3 desc;
```

9. Identify Branches with Highest Revenue Decline Year-Over-Year
  ● Question: Which branches experienced the largest decrease in revenue compared to the previous year?
  ● Purpose: Detecting branches with declining revenue is crucial for understanding possible local issues and creating strategies to boost sales or mitigate losses.alter

```sq
with cte as
(select   
     branch , 
     year(date_format(date, "%d-%m-%y") )  as year,
     sum(total) as revenue,
     lag(sum(total)) over(partition by branch order by year(date_format(date, "%d-%m-%y")) asc )  as py_revenue
from walmart
group by 1, 2
order by 1, 2)
select 
	 *,
     (py_revenue - revenue)/ (py_revenue) * 100 as revenue_decline_perc
from cte
order by 1, 5 desc;
```
select * from walmart; 
