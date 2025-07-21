# walmart_SQL-Python


Walmart Business Problems 


1. Analyze Payment Methods and Sales ● Question: What are the different payment 
methods, and how many transactions and items were sold with each method? ● Purpose: 
This helps understand customer preferences for payment methods, aiding in payment 
optimization strategies.

```sq
select 
	  payment_method , 
      count(*) as total_transaction, 
      sum(quantity) as total_quantity
from walmart
group by payment_method
order by 2 desc , 3 desc;
```

3. Identify the Highest-Rated Category in Each Branch ● Question: Which category received 
the highest average rating in each branch? ● Purpose: This allows Walmart to recognize and 
promote popular categories in specific branches, enhancing customer satisfaction and 
branch-specific marketing.  
4. Determine the Busiest Day for Each Branch ● Question: What is the busiest day of the 
week for each branch based on transaction volume? ● Purpose: This insight helps in 
optimizing staffing and inventory management to accommodate peak days.  
5. Calculate Total Quantity Sold by Payment Method ● Question: How many items were sold 
through each payment method? ● Purpose: This helps Walmart track sales volume by 
payment type, providing insights into customer purchasing habits.  
6. Analyze Category Ratings by City ● Question: What are the average, minimum, and 
maximum ratings for each category in each city? ● Purpose: This data can guide city-level 
promotions, allowing Walmart to address regional preferences and improve customer 
experiences. 
7. Calculate Total Profit by Category ● Question: What is the total profit for each category, 
ranked from highest to lowest? ● Purpose: Identifying high-profit categories helps focus 
efforts on expanding these products or managing pricing strategies effectively.  
8. Determine the Most Common Payment Method per Branch ● Question: What is the most 
frequently used payment method in each branch? ● Purpose: This information aids in 
understanding branch-specific payment preferences, potentially allowing branches to 
streamline their payment processing systems.  
9. Analyze Sales Shifts Throughout the Day ● Question: How many transactions occur in each 
shift (Morning, Afternoon, Evening) across branches? ● Purpose: This insight helps in 
managing staff shifts and stock replenishment schedules, especially during high-sales 
periods.  
10. Identify Branches with Highest Revenue Decline Year-Over-Year ● Question: Which 
branches experienced the largest decrease in revenue compared to the previous year? ● 
Purpose: Detecting branches with declining revenue is crucial for understanding possible 
local issues and creating strategies to boost sales or mitigate losses 
