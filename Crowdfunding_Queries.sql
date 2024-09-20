# CROWDFUNDING PROJECT

Create Database Crowdfunding;

# Total Number of Projects based on Outcome
Delimiter // 
create procedure Outcome (IN State_ varchar(50))
begin
     select state, count(ProjectID) as Num_of_projects
     from projects
     where state = state_
     Group by state;
end //
Delimiter ;
call outcome("successful");

# Total Number of Projects based on Outcome
select state, count(ProjectID) as total_Projects
from projects
group by state;


# Total Number of Projects based on Locations
select country, count(ProjectID) as Total_Projects
from projects
group by country;

# Total Number of Projects based on Category
select t1.Name as Category, count(ProjectID) as Count_of_Projects
from category as t1 join projects as t2 on t1.id=t2.category_id
group by t1.name
order by Count_of_Projects desc;

# Total Number of Projects created by Year
Select YEAR(created_date) as Year, count(ProjectID) as Projects
from Projects
group by Year 
order by Year desc;

# Total Number of Projects created by Quarter
SELECT CONCAT('Q',QUARTER(created_date)) AS project_quarter, COUNT(*) AS total_projects
FROM projects
GROUP BY project_quarter
ORDER BY project_quarter; 

# Total Number of Projects created by Months
Select monthname(created_date) as Months, Count(ProjectID) as Total_Projects
from projects
group by Months
order by Months;

----------------------------------------------------------------------------------------------------------------

-- # Successful Projects Amount Raised ----------------
Select SUM(goal) as Amount_Raised
from projects
where state = "successful";

# Successful Projects by Number of Backers
Select backers_count as Backers, State
from projects
where state = "successful";

# Successful Projects by Avg number of days for successful Projects
Select Round(Avg(DATEDIFF(deadline_date, created_date))) As Avg_Days_for_Successful_Projects
From projects
Where state = "successful";

-------------------------------------------------------------------------------------------------------------------------

# Top Successful Projects based on Backers
Select name, backers_count as Backers_count, state
from projects
where state = "successful"
order by Backers_count desc
limit 10;

-- # Top Successful Projects based on Amount Raised --
Select ProjectID, state, SUM(goal) as Amount_Raised
from projects
where state = "successful"
group by ProjectID
order by Amount_Raised desc
limit 10;

--------------------------------------------------------------------------------------------------------------------------

# Percentage of Successful Projects overall
Select Concat(Format(SUM(state = "successful") * 100/count(*),2),"%") as Percentage_of_Successful_Projects_overall
from projects;

-- # Perecentage of Successful Projects by Category ?
Select T2.name, Concat(Format(SUM(State = "successful")* 100/count(*),2),"%") as Perecentage_of_Successful_Projects_by_Category
from projects join category as T2 on projects.category_id=T2.id
group by T2.name
order by T2.name;

# Percentage of Successful Projects by Year and Month
Select YEAR(created_date) as Year, Concat(Format(SUM(state = 'successful')*100/count(*),2),"%") as Percentage_of_Successful_Projects_by_Year
from projects
group by Year
order by  Year desc ;

Select monthname(created_date) as Month_Name, Concat(Format(SUM(state = 'successful')*100/count(*),2),"%") as Percentage_of_Successful_Projects_by_Months
from projects
group by Month_Name
order by  Month_Name ;

# Percentage of Successful Projects by Goal Range
select Concat(Format(Sum(state = "successful")*100/count(ProjectID),2),"%") as Percentage_of_Successful_Projects_by_Goal_Range,
CASE 
WHEN goal BETWEEN 0 AND 5000 THEN "0-5,000"
WHEN goal BETWEEN 5001 AND 50000 THEN "5,001-50,000"
WHEN goal BETWEEN 50001 AND 500000 THEN "50,001-500,000"
WHEN goal BETWEEN 500001 AND 100000000 THEN "500,001-100,000,000"
END as goal_Range
from projects
group by goal_Range;