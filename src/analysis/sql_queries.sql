-- Sample 20 analysis queries
-- 1
SELECT player_of_match AS player, COUNT(*) AS pom_awards
FROM odi_matches WHERE player_of_match IS NOT NULL
GROUP BY player ORDER BY pom_awards DESC LIMIT 10;

-- 2
SELECT winner, COUNT(*) AS wins FROM odi_matches
WHERE winner IS NOT NULL GROUP BY winner ORDER BY wins DESC LIMIT 10;

-- 3
SELECT winner, COUNT(*) AS wins FROM test_matches
WHERE winner IS NOT NULL GROUP BY winner ORDER BY wins DESC;

-- 4
SELECT winner, COUNT(*) AS wins FROM t20_matches
WHERE winner IS NOT NULL GROUP BY winner ORDER BY wins DESC;

-- 5
SELECT winner, COUNT(*) AS wins FROM ipl_matches
WHERE winner IS NOT NULL GROUP BY winner ORDER BY wins DESC;

-- 6
SELECT SUBSTR(date,1,4) AS year, COUNT(*) AS matches FROM odi_matches
GROUP BY year ORDER BY year;

-- 7
SELECT venue, COUNT(*) AS matches FROM odi_matches
GROUP BY venue ORDER BY matches DESC LIMIT 10;

-- 8
SELECT toss_decision, COUNT(*) AS matches FROM odi_matches
GROUP BY toss_decision ORDER BY matches DESC;

-- 9
SELECT player_of_match AS player, COUNT(*) AS awards FROM t20_matches
WHERE player_of_match IS NOT NULL
GROUP BY player ORDER BY awards DESC LIMIT 15;

-- 10
SELECT venue, COUNT(*) AS matches FROM t20_matches
GROUP BY venue ORDER BY matches DESC LIMIT 10;

-- 11
SELECT SUBSTR(date,1,4) AS year, COUNT(*) AS matches FROM t20_matches
GROUP BY year ORDER BY year;

-- 12
SELECT SUBSTR(date,1,4) AS year, COUNT(*) AS matches FROM test_matches
GROUP BY year ORDER BY year;

-- 13
SELECT team1 || ' vs ' || team2 AS fixture, COUNT(*) AS meetings FROM odi_matches
GROUP BY fixture ORDER BY meetings DESC LIMIT 20;

-- 14
SELECT team1 || ' vs ' || team2 AS fixture, COUNT(*) AS meetings FROM t20_matches
GROUP BY fixture ORDER BY meetings DESC LIMIT 20;

-- 15
SELECT toss_winner, COUNT(*) AS toss_wins FROM odi_matches
GROUP BY toss_winner ORDER BY toss_wins DESC;

-- 16
WITH games AS (
  SELECT team1 AS team, winner FROM odi_matches
  UNION ALL
  SELECT team2 AS team, winner FROM odi_matches
)
SELECT team,
       SUM(CASE WHEN winner = team THEN 1 ELSE 0 END) AS wins,
       COUNT(*) AS played,
       ROUND(100.0*SUM(CASE WHEN winner = team THEN 1 ELSE 0 END)/COUNT(*),2) AS win_pct
FROM games GROUP BY team HAVING played >= 10
ORDER BY win_pct DESC LIMIT 15;

-- 17
WITH games AS (
  SELECT team1 AS team, winner FROM t20_matches
  UNION ALL
  SELECT team2 AS team, winner FROM t20_matches
)
SELECT team,
       SUM(CASE WHEN winner = team THEN 1 ELSE 0 END) AS wins,
       COUNT(*) AS played,
       ROUND(100.0*SUM(CASE WHEN winner = team THEN 1 ELSE 0 END)/COUNT(*),2) AS win_pct
FROM games GROUP BY team HAVING played >= 10
ORDER BY win_pct DESC LIMIT 15;

-- 18
WITH games AS (
  SELECT team1 AS team, winner FROM test_matches
  UNION ALL
  SELECT team2 AS team, winner FROM test_matches
)
SELECT team,
       SUM(CASE WHEN winner = team THEN 1 ELSE 0 END) AS wins,
       COUNT(*) AS played,
       ROUND(100.0*SUM(CASE WHEN winner = team THEN 1 ELSE 0 END)/COUNT(*),2) AS win_pct
FROM games GROUP BY team HAVING played >= 10
ORDER BY win_pct DESC;

-- 19
SELECT venue, player_of_match, COUNT(*) AS awards FROM odi_matches
WHERE player_of_match IS NOT NULL
GROUP BY venue, player_of_match ORDER BY awards DESC LIMIT 25;

-- 20
SELECT venue, winner, COUNT(*) AS wins FROM odi_matches
WHERE winner IS NOT NULL
GROUP BY venue, winner ORDER BY wins DESC LIMIT 25;