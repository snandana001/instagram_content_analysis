# 1 How many unique post types are found in the 'fact_content' table? 
 SELECT 
     DISTINCT post_type  AS distinct_post_types
FROM 
    gdb0120.fact_content;
#ans:4
# 2 What are the highest and lowest recorded impressions for each post type?
 SELECT post_type ,
    MAX(impressions) AS max_impressions,min(impressions) as min_impressions
FROM 
    fact_content
group by post_type ;

#ans:339708

#ans:3264
# 3 Filter all the posts that were published on a weekend in the month of March and April and export them to a separate csv file.
 SELECT * 
FROM fact_content fc
JOIN dim_dates dt ON dt.date = fc.date
WHERE 
    weekday_or_weekend = 'weekend'
    AND (
        month_name = 'March' OR month_name = 'April'
    );

# ans:Done
# 4 Create a report to get the statistics for the account
with cte as (
SELECT 
    dt.month_name,
    SUM(profile_visits) AS total_profile_visits,
    SUM(new_followers) AS total_new_followers
FROM 
    fact_account fa
JOIN 
    dim_dates dt ON dt.date = fa.date
GROUP BY 
    dt.month_name
ORDER BY 
    FIELD(dt.month_name, 
        'January', 'February', 'March', 'April', 
        'May', 'June', 'July', 'August', 
        'September', 'October', 'November', 'December'))
select *,round(total_new_followers*100/total_profile_visits,2) as conversion_rate from cte;

#ans:done
# 5 Write a CTE that calculates the total number of 'likes’ for each 'post_category' 
#during the month of 'July' and subsequently, arrange the 'post_category' values 
#in descending order according to their total likes
 WITH cte AS (
    SELECT  post_category, likes, dt.month_name, dt.date
    FROM 
        fact_content fc
    JOIN 
        dim_dates dt ON dt.date = fc.date
)
SELECT 
    post_category,
    SUM(likes) AS total_likes
FROM 
    cte
WHERE 
    month_name = 'July'
GROUP BY 
    post_category
ORDER BY 
    total_likes DESC;

# 6 Create a report that displays the unique post_category names alongside their 
#respective counts for each month. The output should have three columns:monthname,post category,post category count

SELECT 
    dt.month_name,
    GROUP_CONCAT(DISTINCT fc.post_category ORDER BY fc.post_category) AS post_category_names,
    COUNT(DISTINCT fc.post_category) AS category_count
FROM 
    fact_content fc
JOIN 
    dim_dates dt ON dt.date = fc.date
GROUP BY 
    dt.month_name
ORDER BY 
    FIELD(dt.month_name, 
        'January', 'February', 'March', 'April', 
        'May', 'June', 'July', 'August', 
        'September', 'October', 'November', 'December');


# 7 What is the percentage breakdown of total reach by post type? The final output 
#includes the following fields: post type,total reach,reach percentage
 WITH cte AS (
    SELECT 
        post_type,
        SUM(reach) AS total_reach
    FROM 
        fact_content
    GROUP BY 
        post_type
)

SELECT 
    *,
    ROUND(total_reach * 100 / (SELECT SUM(total_reach) FROM cte), 2) AS reach_percentage
FROM 
    cte
ORDER BY 
    reach_percentage DESC;


# 8 Create a report that includes the quarter, total comments, and total saves recorded 
#for each post category. Assign the following quarter groupings:
select   dt.quarter,post_category,sum(comments) as total_comments,sum(saves) as total_saves FROM fact_content fc
join dim_dates dt on dt.date=fc.date
group by post_category,quarter;

# 9 List #the top three dates in each month with the highest number of new followers. The final output should include the following columns:
WITH cte AS (
    SELECT 
        dt.month_name,
        fa.new_followers,
        fa.date,
        ROW_NUMBER() OVER (
            PARTITION BY dt.month_name 
            ORDER BY fa.new_followers
        ) AS rn
    FROM 
        fact_account fa
    JOIN 
        dim_dates dt ON dt.date = fa.date
	order by  fa.new_followers asc
)

SELECT  month_name AS month, date, new_followers
FROM cte
WHERE rn <= 3
ORDER BY 
    FIELD(month , 
        'January', 'February', 'March', 'April', 
        'May', 'June', 'July', 'August', 
        'September'), date ;
# 10 Create a stored procedure that takes the 'Week_no' as input and generates a report 
#displaying the total shares for each 'Post_type'. The output of the procedure should consist of two columns:

DELIMITER $$
create procedure get_total_share(in week_no_input VARCHAR(3))
begin 
select post_type,sum(shares) as total_shares from fact_content fc
join dim_dates dt on dt.date=fc.date
where dt.week_no=week_no_input
group by post_type;
end $$ 
DELIMITER ;

call get_total_share('W3')

# monthly growth rate
 WITH cte AS (
    SELECT  SUM(fa.new_followers) AS new_followers,dt.month_name,
        dt.month_number
    FROM fact_account fa
    JOIN dim_dates dt ON fa.date = dt.date
    GROUP BY dt.month_name, dt.month_number
),
lagg AS (SELECT *,LAG(new_followers) OVER (ORDER BY month_number) AS prev
    FROM cte)
SELECT month_name,ROUND((new_followers - prev) * 100.0 / prev, 2) 
AS monthly_growth_rate FROM lagg
    WHERE prev IS NOT NULL


SELECT ROUND(AVG(monthly_growth_rate), 2) AS avg_monthly_growth_rate
FROM rate;



