create database coffee_sales;
use coffee_sales;
# add table data using import prosses
show tables;

SELECT 
    *
FROM
    coffee_sales.coffee;

# 1 TOTAL SALES REVENUE
SELECT 
    SUM(money) AS total_revenue
FROM
    coffee;

# 2 TOTAL TRANSACTIONS BY PAYMENT METHOD
SELECT 
    cash_type, COUNT(*) AS total_transaction
FROM
    coffee
GROUP BY cash_type;

# 3 DAILY SALES SUMMARY
SELECT 
    date, SUM(money) AS Total_sales
FROM
    coffee
GROUP BY date
ORDER BY date;

# 4 BEST-SELLING COFFEE TYPES
SELECT 
    coffee_name, COUNT(*) AS total_sold
FROM
    coffee
GROUP BY coffee_name
ORDER BY total_sold DESC;

# 5 PEAK SALES HOURS (HOURLY TRANSACTIONS)
SELECT 
    HOUR(time) AS sales_hour, COUNT(*) AS total_sales
FROM
    coffee
GROUP BY sales_hour
ORDER BY total_sales DESC;

# 6 AVERAGE ORDER VALUE (AOV)
SELECT 
    AVG(money) AS AOV
FROM
    coffee;

# 7 DAILY SALES TRAND (LAST 7 DAYS)
SELECT 
    date, SUM(money) AS daily_sales
FROM
    coffee
WHERE
    date >= CURDATE() - INTERVAL 7 DAY
GROUP BY date
ORDER BY date;

# 8 SALES CONTRIBUTION BY COFFEE TYPE (%)
SELECT 
    coffee_name,
    SUM(money) AS total_revenue,
    (SUM(money) * 100 / (SELECT 
            SUM(money)
        FROM
            coffee)) AS Percentage_contribution
FROM
    coffee
GROUP BY coffee_name
ORDER BY total_revenue DESC;

# 9 RETURNING CUSTOMERS (LOYALTY ANALYSIS)
SELECT 
    card, COUNT(*) AS total_purchases, SUM(money) AS total_spent
FROM
    coffee
WHERE
    card IS NOT NULL
GROUP BY card
ORDER BY total_spent DESC
LIMIT 10;

# 10 TOP PAYMENT METHOD BY REVENUE
SELECT 
    cash_type, SUM(money) AS total_revenue
FROM
    coffee
GROUP BY cash_type
ORDER BY total_revenue DESC;

# 11 MOST POPULAR COFFEE TYPE PER DAY
SELECT 
    coffee_name, COUNT(*) AS total_sold
FROM
    coffee
GROUP BY date , coffee_name
ORDER BY date , total_sold DESC;

# 12 TOTAL REVENUE PER CUSTOMER (CARD PAYMENTS ONLY)
SELECT 
    card, SUM(money) AS total_revenue
FROM
    coffee
WHERE
    cash_type = 'card'
GROUP BY card
ORDER BY total_revenue DESC;

# 13 DAILY SALES GROWTH RATE
select date,
    sum(money) as daily_sales,
    lag(sum(money)) over (order by date) as previous_day_sales,
    (sum(money) - lag(sum(money)) over (order by date)) / lag(sum(money)) over
    (order by date) * 100 as groth_rate
from coffee 
group by date
order by date;

# 14 BEST SALES DAY (HIGHEST RECENUE DAY)
SELECT 
    date, SUM(money) AS total_sales
FROM
    coffee
GROUP BY date
ORDER BY total_sales DESC
LIMIT 1;

# 15 IDENTIFY SALES DROP DAYS ( COMPARED TO PREVIOUS DAY)
select date,
sum(money) as daily_sales,
lag(sum(money)) over ( order by date) as previous_day_sales,
case
when sum(money) < lag(sum(money)) over (order by date)
then 'sales drfopped'
else 'sales increased'
end as sales_trend
from coffee 
group by date
order by date;

# 16 CUSTOMER SEGMENTATION BASED ON SPENDING
SELECT 
    card,
    SUM(money) AS total_spent,
    CASE
        WHEN SUM(money) > 500 THEN 'Hign Spender'
        WHEN SUM(money) BETWEEN 200 AND 500 THEN 'Medium Spender'
        ELSE 'low Spender'
    END AS customer_segment
FROM
    coffee
WHERE
    card IS NOT NULL
GROUP BY card
ORDER BY total_spent DESC;

# 17 COFFEE TYPE POPULARTY BASED ON SALES TRAND OVER TIME
SELECT 
    coffee_name, date, COUNT(*) AS total_sold
FROM
    coffee
GROUP BY coffee_name , date
ORDER BY coffee_name , date;

# 18 PEAK SALES DAYS OF THE WEEK
SELECT 
    DAYNAME(date) AS day_of_week, COUNT(*) AS total_sales
FROM
    coffee
GROUP BY day_of_week
ORDER BY total_sales DESC;




