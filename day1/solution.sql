SELECT
    c.name,
    JSON_EXTRACT(w.wishes, '$.first_choice') AS primary_wish,
    JSON_EXTRACT(w.wishes, '$.second_choice') AS secondary_wish,
    JSON_EXTRACT(w.wishes, '$.colors[0]') AS color,
    JSON_LENGTH(w.wishes, '$.colors') AS color_count,
    CASE
        WHEN tc.difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN tc.difficulty_to_make = 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE
        WHEN tc.category = 'outdoor' THEN 'Outside Workshop'
        WHEN tc.category = 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM
    children AS c
    JOIN wish_lists AS w ON c.child_id = w.child_id
    JOIN toy_catalogue AS tc ON JSON_EXTRACT(w.wishes, '$.first_choice') = tc.toy_name
ORDER BY
    c.name ASC;