
SELECT 
    event_id, transport_type, transport_line, 
    (
        CASE
        WHEN position(')' IN reverse(station)) > 0 THEN
            substring(
                    station,
                    0,
                    (length(station) - position('(' IN reverse(station)))
                    )
        ELSE
            station
        END
    ) AS station,
    (
        CASE
        WHEN position(')' IN reverse(station)) > 0 THEN
            CAST(
                substring(
                    station,
                    (length(station) - position('(' IN reverse(station)) + 2),
                    position('(' IN reverse(station)) - position(')' IN reverse(station)) - 2
                    )
                AS FLOAT
            )
        ELSE
            NULL
        END
    ) AS distance
FROM (
    SELECT 
        et.event_id,
        CAST(split_part(transport, '->', 1) AS TEXT) AS transport_type,
        CAST(
            split_part(split_part(transport, '->', 2), ':', 1) 
            AS TEXT) AS transport_line,
        CAST(
            split_part(split_part(transport, '->', 2), ':', 2)
            AS TEXT) AS station
    FROM (
            SELECT event_id, transport FROM (
                SELECT 
                    event_id, 
                    unnest(string_to_array(transport, E'\n')) AS transport
                FROM temp_event
                WHERE
                    transport IS NOT NULL AND LENGTH(transport) > 2
            ) AS t WHERE transport NOT LIKE '<%'
        ) AS temp_transport
        INNER JOIN event_table et 
        ON temp_transport.event_id = et.event_id
) AS temp_transport
LIMIT 10;