/*1789. Primary Department for Each Employee

Table: Employee
+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', 
the department is the primary department for the employee. If the flag is 'N', the department is not the primary.

Employees can belong to multiple departments. When the employee joins other departments, 
they need to decide which department is their primary department. 
Note that when an employee belongs to only one department, their primary column is 'N'.
Write a solution to report all the employees with their primary department. 
For employees who belong to one department, report their only department.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
Output: 
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
Explanation: 
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.*/

Question Link: https://leetcode.com/problems/primary-department-for-each-employee/

 SELECT EMPLOYEE_ID,DEPARTMENT_ID
FROM
(SELECT *,COUNT(EMPLOYEE_ID) OVER(PARTITION BY EMPLOYEE_ID) C
FROM EMPLOYEE)T
WHERE C=1 OR PRIMARY_FLAG='YEAR';

 WITH sub AS (
SELECT *,
       COUNT(department_id) OVER (PARTITION BY employee_id) AS cnt
FROM Employee)

SELECT employee_id,
       department_id
FROM sub
WHERE (cnt >1 AND primary_flag= 'Y')
OR (cnt=1); 

select emp.employee_id, department_id from Employee emp
INNER JOIN (
	Select employee_id, COUNT(department_id) as DeptCount
	from Employee
	group by employee_id
) NoOfYDept ON emp.employee_id = NoOfYDept.employee_id
where (primary_flag = 'Y' AND NoOfYDept.DeptCount > 0) OR 
(primary_flag = 'N' AND NoOfYDept.DeptCount <= 1)
group by emp.employee_id, department_id;

SELECT e1.employee_id, e1.department_id
FROM Employee AS e1
LEFT JOIN
(
SELECT employee_id, COUNT(department_id) AS dep_count
FROM Employee
GROUP BY employee_id
) AS e2
ON e1.employee_id = e2.employee_id
WHERE primary_flag = 'Y' OR dep_count = 1;