'''
Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
'''

SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT 
        num,
        CASE 
            WHEN num = LAG(num) OVER (ORDER BY id) 
                 AND num = LAG(num, 2) OVER (ORDER BY id) 
            THEN 1
            ELSE 0
        END AS is_consecutive
    FROM Logs
) t
WHERE is_consecutive = 1;
