/*1667. Fix Names in a Table

Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id.

The result format is in the following example.

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+*/

Question link: https://leetcode.com/problems/fix-names-in-a-table/description/

SELECT 
    user_id, 
    (UPPER(LEFT(name, 1))+ LOWER(SUBSTRING(name, 2, LEN(name)))) AS name
FROM users
ORDER BY user_id;

SELECT 
    user_id, 
    CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2, len(name)))) AS name
FROM users
ORDER BY user_id;

SELECT user_id,
       UPPER(LEFT(name,1)) + LOWER(RIGHT(name,LEN(name) - 1)) AS name
FROM Users
order by user_id;
