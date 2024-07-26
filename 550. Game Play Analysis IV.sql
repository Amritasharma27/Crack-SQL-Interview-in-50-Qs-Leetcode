/*550. Game Play Analysis IV

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, 
rounded to 2 decimal places. In other words, you need to count the number of players that logged in for 
at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.
 
Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33*/

Question Link : https://leetcode.com/problems/game-play-analysis-iv/

with totalPlayer as (
    select count(distinct player_id) as total_players
    from activity
), first_login as (
    select player_id, min(event_date) as first_login
    from activity
    group by player_id
), consecutive_logins as(
    select A.player_id, count(*) as consecutive_days
    from activity A
    inner join first_login f on f.player_id = A.player_id
    inner join activity A2 on A2.player_id = A.player_id
                            and A2.event_date = dateadd(day,1,f.first_login)
    group by A.player_id
)
select round(cast(count(*) as float)/ (SELECT total_players FROM totalPlayer), 2) as fraction
from consecutive_logins;

WITH First_login AS (
    SELECT 
        player_id, 
        MIN(event_date) AS event_date
    FROM 
        Activity
    GROUP BY 
        player_id
)
SELECT 
	ROUND(
        Cast(SUM(case when (abs(datediff(day,A.event_date,F.event_date)) = 1) then 1 else 0 end) AS float)
		/ COUNT(DISTINCT A.player_id), 2)
     AS fraction 
FROM 
    Activity AS A
JOIN 
    First_login AS F
    ON F.player_id = A.player_id;

select round(sum(case 
                    when event_date=fdate then 1 else 0 end)*1.0
                    /count(distinct activity.player_id),2) as fraction 
from activity 
join (
    select player_id, dateadd(day,1,min(event_date)) as fdate 
    from activity 
    group by player_id) as a 
    on activity.player_id=a.player_id
