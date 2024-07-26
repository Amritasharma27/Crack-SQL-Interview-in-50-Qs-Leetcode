/*185. Department Top Three Salaries

Table: Employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.

A company's executives are interested in seeing who earns the most money in each of the company's departments.
A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write a solution to find the employees who are high earners in each of the departments.
Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees*/

Question Link: https://leetcode.com/problems/department-top-three-salaries/

with high_earners as (
    select *, 
    dense_rank() over( partition by departmentId order by salary desc) as rnk
    from employee
)

select d.name department, he.name as Employee, he.salary as Salary
from high_earners he
join department d
on d.id = he.departmentId
where rnk <=3;

With cte as (
select dense_rank() OVER(PARTITION BY d.name order by e.salary desc ) as rn, d.name as Department, e.name as Employee, E.salary as Salary
From employee e
Join Department d
On e.departmentId = d.id
)

Select 
Department, Employee, Salary
From cte
WHERE 
    rn <= 3
ORDER BY 
    Department, rn; 

 with q1 as (select 
    e.*,
    d.name as Department, 
    dense_rank() over(partition by departmentID order by salary desc) as row_count
from Employee as e
inner join Department as d on d.id = e.departmentId
)

select 
    Department,
    q1.name as Employee,
    q1.salary as Salary
from q1
where row_count <=3
ORDER BY Department, salary DESC;
