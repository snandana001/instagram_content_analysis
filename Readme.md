# Instagram content Analysis

This repository contains SQL scripts used for analyzing instagram_content data of a tech page using MySQL.

## 📁 Contents

- ` instagram_content_analaysis.sql` – Main SQL script  

## 📊 Project Overview

The project involves analyzing three database tables containing Instagram activity data. the goal is to explore this data, answer key questions, and create actionable insights.
This analysis explores:

1. How many unique post types are found in the 'fact_content' table?
2. What are the highest and lowest recorded impressions for each post type?
3. Filter all the posts that were published on a weekend in the month of March and April and export them to a separate csv file.
4. Create a report to get the statistics for the account. The final output includes the following fields:
• month_name
• total_profile_visits
• total_new_followers
5. Write a CTE that calculates the total number of 'likes’ for each 'post_category' during the month of 'July' and subsequently, arrange the 'post_category' values in     descending order according to their total likes.
6. Create a report that displays the unique post_category names alongside their respective counts for each month. The output should have three columns:
•month_name
•post_category_names
•post_category_count
Example:
•April', 'Earphone,Laptop,Mobile,Other Gadgets,Smartwatch', '5'
•'February', 'Earphone,Laptop,Mobile,Smartwatch', '4'
 
7.What is the percentage breakdown of total reach by post type? The final output includes the following fields:
•post_type
•total_reach
•reach_percentage
8.Create a report that includes the quarter, total comments, and total saves recorded for each post category. Assign the following quarter groupings:
(January, February, March) → “Q1”
(April, May, June) → “Q2”
(July, August, September) → “Q3”
The final output columns should consist of:
•post_category
•quarter
•total_comments
•total_saves
9.List the top three dates in each month with the highest number of new followers. The final output should include the following columns:
•month
•date
•new_followers
10.Create a stored procedure that takes the 'Week_no' as input and generates a report displaying the total shares for each 'Post_type'. The output of the procedure should consist of two columns:
•post_type
•total_shares
 
 

## 🛠️ Tools Used

- **MySQL Workbench**
- **MySQL Server 8.0**
- **Power BI** (for visualization)

 

 
