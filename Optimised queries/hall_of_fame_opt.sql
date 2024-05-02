SELECT
    u.id AS user_id,
    u.display_name,
    (COALESCE(u.up_votes, 0) - COALESCE(u.down_votes, 0)) AS reputation,
    CASE
        WHEN (COALESCE(u.up_votes, 0) - COALESCE(u.down_votes, 0)) >= 100000 THEN '★★★★★'
        WHEN (COALESCE(u.up_votes, 0) - COALESCE(u.down_votes, 0)) >= 60000 THEN '★★★★'
        WHEN (COALESCE(u.up_votes, 0) - COALESCE(u.down_votes, 0)) >= 30000 THEN '★★★'
        ELSE '★'
    END AS star_rating
FROM
    `bigquery-public-data.stackoverflow.users` u
JOIN
    `bigquery-public-data.stackoverflow.comments` c
ON
    u.id = c.user_id
GROUP BY
    user_id, display_name, reputation, star_rating
ORDER BY
    reputation DESC
LIMIT
    10;