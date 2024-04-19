
SELECT 
    et.event_id,
    CAST(split_part(transport, '->', 1) AS TEXT) AS transport_type,
    CAST(
        split_part(split_part(transport, '->', 2), ':', 1) 
        AS TEXT) AS transport_line,
    CAST(
        split_part(split_part(transport, '->', 2), ':', 2)
        AS TEXT) AS station
FROM 
    (
        SELECT event_id, transport FROM (
            SELECT 
                event_id, 
                unnest(string_to_array(transport, E'\n')) AS transport
            FROM temp_event
            WHERE
                transport IS NOT NULL AND LENGTH(transport) > 2
        ) AS t WHERE transport NOT LIKE '<%'
        LIMIT 10
    ) AS temp_transport
    INNER JOIN event_table et 
    ON temp_transport.event_id = et.event_id
LIMIT 10;


-- SELECT * FROM
-- (
-- ) AS t
-- WHERE transport_type IS NOT NULL
-- LIMIT 2;
-- -- ON CONFLICT DO NOTHING;