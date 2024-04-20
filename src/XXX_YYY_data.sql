---------------------
\i d_header.sql
\echo [PART 1]
\echo

\echo Number of events with pmr, blind or deaf access :

SELECT COUNT(event_id) 
FROM event_table
WHERE (
    address_name,
    address_street, 
    address_zipcode, 
    address_city
) IN (
    SELECT address_name, address_street, address_zipcode, address_city
    FROM address_table
    WHERE (pmr=TRUE) OR (deaf=TRUE) OR (blind=TRUE) 
);

\echo Number of events accessibles with "Vélib"

SELECT COUNT(DISTINCT event_id) AS count
FROM transport
WHERE transport_type LIKE '%Vélib%';

\echo Number of events with multiple transports :

SELECT COUNT(DISTINCT event_id) AS count
FROM (
    SELECT event_id
    FROM transport
    GROUP BY event_id
    HAVING COUNT(DISTINCT transport_type) > 1
) AS events_with_multiple_transports;

\prompt 'Press Enter to continue...' ''
SELECT 1;
\i d_header.sql
---------------------------------------------------------------
\echo [PART 2]
\echo

\echo The 10 station with the most events

SELECT 
    COUNT(event_id) as count, 
    transport_type, transport_line, station
FROM transport
GROUP BY (transport_type, transport_line, station)
ORDER BY count DESC
LIMIT 10;

\echo The title of the 10 events with the most occurrences

SELECT
    COUNT(l.event_id) as count, l.event_id as id, title
FROM
    event_table AS l LEFT JOIN occurrence AS r
    ON l.event_id = r.event_id
GROUP BY (l.event_id)
ORDER BY count DESC
LIMIT 10;

\prompt 'Press Enter to continue...' ''
SELECT 1;
\i d_header.sql
---------------------------------------------------------------
\echo [PART 3]
\echo

\echo The 10 most used tag
SELECT
    COUNT(l.event_id) as count, keyword
FROM
    event_table AS l INNER JOIN tag AS r
    ON l.event_id = r.event_id
GROUP BY (keyword)
ORDER BY count DESC
LIMIT 10;


\echo The 10 biggest group
SELECT COUNT(event_id) as count, group_name
FROM
    event_table
GROUP BY (group_name)
ORDER BY count DESC
LIMIT 10;

\prompt 'Press Enter to continue...' ''
SELECT 1;
\! clear
---------------------------------------------------------------