'''
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

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
'''

WITH FirstLogin AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM
        Activity
    GROUP BY
        player_id
),
FollowUpLogins AS (
    SELECT DISTINCT
        a.player_id
    FROM
        Activity a
    JOIN
        FirstLogin fl
    ON
        a.player_id = fl.player_id
        AND a.event_date = DATE_ADD(fl.first_login_date, INTERVAL 1 DAY)
),
TotalPlayers AS (
    SELECT COUNT(DISTINCT player_id) AS total_players
    FROM Activity
),
RepeatLogins AS (
    SELECT COUNT(*) AS repeat_players
    FROM FollowUpLogins
)
SELECT
    ROUND(CAST(repeat_players AS DECIMAL) / total_players, 2) AS fraction
FROM
    RepeatLogins, TotalPlayers;
