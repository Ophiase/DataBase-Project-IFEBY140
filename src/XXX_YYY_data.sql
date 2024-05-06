---------------------
\i d_header.sql
\echo [PART 1]
\echo

\echo Number of events :
SELECT COUNT(event_id) FROM event_table;

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

\prompt 'Enter a tag : ' input_tag

\echo The most recent events using the tag :input_tag :

SELECT
    l.date_begin,
    l.title
FROM
    event_table AS l
    INNER JOIN
    tag AS r ON l.event_id = r.event_id
WHERE
    r.keyword = :'input_tag'
    AND date_begin IS NOT NULL
ORDER BY
    l.date_begin DESC
LIMIT
    10;    

\prompt 'Press Enter to continue...' ''
SELECT 1;

\! clear
---------------------------------------------------------------
\echo [PART 4]
\echo

\echo The 10 biggest group
SELECT COUNT(event_id) as count, group_name
FROM
    event_table
GROUP BY (group_name)
ORDER BY count DESC
LIMIT 10;

\prompt 'Enter a group : ' input_group

\echo The most recent events in the group :input_group :

SELECT
    date_begin,
    title
FROM
    event_table
WHERE
    group_name = :'input_group'
    AND date_begin IS NOT NULL
ORDER BY
    date_begin DESC
LIMIT
    10;    


\prompt 'Press Enter to continue...' ''
SELECT 1;

\! clear
---------------------------------------------------------------
\echo [PART 5]
\echo

\echo 'All mobilities availible'

SELECT transport_type 
FROM transport
GROUP BY transport_type;

\prompt 'Enter your mobility : ' input_transport

\echo Most recents event accessible with :input_transport

SELECT date_begin, title
FROM transport NATURAL JOIN event_table
WHERE transport_type = :'input_transport'
GROUP BY (event_id, date_begin, title)
ORDER BY date_begin DESC
LIMIT 10;

\prompt 'Press Enter to continue...' ''
SELECT 1;

\! clear
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION haversine_distance(
    lat1 double precision, lon1 double precision,
    lat2 double precision, lon2 double precision)
RETURNS double precision AS $$
DECLARE
    d_lat double precision;
    d_lon double precision;
    a double precision;
    c double precision;
    d double precision;
    R double precision := 6371; 
BEGIN
    d_lat := radians(lat2 - lat1);
    d_lon := radians(lon2 - lon1);
    
    a := sin(d_lat / 2) * sin(d_lat / 2) +
         cos(radians(lat1)) * cos(radians(lat2)) *
         sin(d_lon / 2) * sin(d_lon / 2);
    
    c := 2 * atan2(sqrt(a), sqrt(1 - a));
    
    d := R * c;
    
    RETURN d;
END;
$$ LANGUAGE plpgsql;


\echo [PART 5]
\echo

\prompt 'Enter your  : lat' user_lat
\prompt 'Enter your  : lon' user_lon

\echo Nearest activity with user_lat, user_lon

SELECT event_id, title, date_begin, date_end, address_name, et.address_street, et.address_zipcode, et.address_city, lat, lon,
       haversine_distance(user_lat, user_lon, gc.lat, gc.lon) AS distance
FROM event_table AS et
JOIN geographic_correspondance AS gc ON et.address_street = gc.address_street
                                       AND et.address_zipcode = gc.address_zipcode
                                       AND et.address_city = gc.address_city
ORDER BY distance
LIMIT 10;

\prompt 'Press Enter to continue...' ''
SELECT 1;

\! clear