create database hr_data;

use hr_data;

#Changing column name
alter table hrtb change ï»¿attrition attrition varchar(10);
select * from hrtb;

# Q1. Average Attrition Rate for All Department
select a.department, concat(round(avg(a.attr)*100,2),'%') as 'AttritionRate'
from
(select 
	department, attrition,
    case
		when attrition ='Yes' then 1
        else 0
	end as 'attr'
from hrtb) as a
group by a.department
order by AttritionRate desc;


# Q2. Average Hourly Rate for Male Research Scientist
select gender, job_role as 'Job Role', round(avg(hourly_rate),2) as 'Average Hourly Rate'
from hrtb
where gender = 'Male' and job_role = 'Research Scientist';


# Q3. AttritionRate VS MonthlyIncomeStats against department
select 
	a.department, 
	concat(round(avg(a.attr)*100,2),'%') as 'AttritionRate',
    round(avg(monthly_income), 2) as 'AverageMonthlyIncome'
from
(select 
	department, attrition, monthly_income,
    case
		when attrition ='Yes' then 1
        else 0
	end as 'attr'
from hrtb) as a
group by a.department
order by AverageMonthlyIncome desc;

# OR ------------------------
select 
	department, 
	concat(round(avg(case when attrition = 'Yes' then 1 else 0 end)*100,2),'%') as 'AttritionRate',
    round(avg(monthly_income), 2) as 'AverageMonthlyIncome'
from hrtb
group by department
order by AverageMonthlyIncome desc;


# Q4. Average Working Years for Each Department
select department, round(avg(total_working_years), 2) as 'Average working years'
from hrtb
group by department;


# Q5. Job Role VS Work Life Balance
SELECT job_role,
	SUM(case when performance_rating = 1 then 1 else 0 end) AS 1st_Rating_Total,
	SUM(case when performance_rating = 2 then 1 else 0 end) AS 2nd_Rating_Total,
	SUM(case when performance_rating = 3 then 1 else 0 end) AS 3rd_Rating_Total,
	SUM(case when performance_rating = 4 then 1 else 0 end) AS 4th_Rating_Total, 
	COUNT(*) AS Total_Employee, 
	FORMAT(AVG(work_life_balance),2) AS Average_WorkLifeBalance_Rating
FROM hrtb 
GROUP BY job_role;


# Q6. Attrition Rate Vs Year Since Last Promotion Relation Against Job Role
select 
	a.job_role, 
	concat(round(avg(a.attr)*100,2),'%') as 'AttritionRate',
    round(avg(years_since_last_promotion), 2) as 'YearsSinceLastPromotion'
from
(select 
	job_role, attrition, years_since_last_promotion,
    case
		when attrition ='Yes' then 1
        else 0
	end as 'attr'
from hrtb) as a
group by a.job_role
order by YearsSinceLastPromotion desc;

# OR ----------------------------
select 
	job_role, 
	concat(round(avg(case when attrition = 'Yes' then 1 else 0 end)*100,2),'%') as 'AttritionRate',
    round(avg(years_since_last_promotion), 2) as 'YearsSinceLastPromotion'
from hrtb
group by job_role
order by YearsSinceLastPromotion desc;


# select sum(case when attrition = 'Yes' then 1 else 0 end) as 'Attrition' from hrtb;
