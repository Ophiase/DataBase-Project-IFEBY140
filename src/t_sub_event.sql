SELECT 
    et.event_id, 
    CAST(split_part(geographic_coordinate, '->', 0) AS TEXT) AS transport_type,
    CAST(
        split_part(split_part(geographic_coordinate, '->', 0), ':', 0) 
        AS TEXT) AS transport_line,
    CAST(
        split_part(split_part(geographic_coordinate, '->', 0), ':' 1) 
        AS TEXT) AS transport_type
FROM
    (
        SELECT 
            event_id, 
            unnest(string_to_array(transport, '+')) AS transport
        FROM temp_event
    ) as temp_transport
    RIGHT JOIN event_table et 
    ON temp_transport.event_id = et.event_id
LIMIT 10;\! echo ---------------------
\! echo - sub_event ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS sub_event CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    sub_event (
        children_event_id INT UNIQUE PRIMARY KEY,
        parent_event_id INT,
        --
        FOREIGN KEY (children_event_id)
            REFERENCES event_table(event_id),
        FOREIGN KEY (parent_event_id)
            REFERENCES event_table(event_id)
    );
