SELECT
    s.song_title,
    COUNT(CASE WHEN up.duration = s.song_duration THEN 1 END) AS total_plays,
    COUNT(CASE WHEN up.duration < s.song_duration THEN 1 END) AS total_skips
FROM
    songs s
LEFT JOIN
    user_plays up ON s.song_id = up.song_id
GROUP BY
    s.song_id, s.song_title
ORDER BY
    total_plays DESC, -- Most plays first
    total_skips ASC   -- Least skips second
LIMIT 1; -- Return only the top result
