/*176. Second Highest Salary

Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.

Write a solution to find the second highest salary from the Employee table. 
If there is no second highest salary, return null (return None in Pandas).
The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+							  
| null                |
+---------------------+*/

Question Link: https://leetcode.com/problems/second-highest-salary/description/

WITH sec_high AS (
    SELECT 
        id, 
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employee
    WHERE salary IS NOT NULL
)
SELECT CASE 
        WHEN MAX(rnk) < 2 
			THEN NULL 
        ELSE 
            (SELECT salary 
			 FROM sec_high 
			 WHERE rnk = 2
			 GROUP BY salary) 
    END AS SecondHighestSalary
FROM sec_high;

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

with cte as(
select
DENSE_RANK() over (order by Salary desc) as "r",
salary
from employee)

select
max(case when r=2 then Salary else null end) as "SecondHighestSalary"
from cte; 

select isnull(
(select distinct salary 
from employee 
order by salary desc
offset 1 rows fetch next 1 rows only)
, null) as SecondHighestSalary;

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary != (SELECT MAX(salary) FROM Employee);