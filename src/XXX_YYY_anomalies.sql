\echo '\033[1;33m--------------------------------------------\033[0m'
\echo '\033[1;33m- Data that don''t fit in the database ...\033[0m'
\echo '\033[1;33m--------------------------------------------\033[0m'

\! echo "Reminder, number of events :"
SELECT COUNT(event_id) AS "events in csv" FROM temp_event;
SELECT COUNT(event_id) AS "events event_table" FROM event_table;
\! echo "----------------------------"

\! echo "Glimpse of data that don't fit into event_table"

SELECT event_id, date_begin, date_end 
FROM temp_event 
WHERE 
    date_end IS NOT NULL AND
    date_begin IS NOT NULL AND
    date_end < date_begin
LIMIT 10;

\! echo "Number of none fully described address :"

SELECT COUNT(event_id) 
FROM temp_event
WHERE
    NOT((address_name, address_street, address_zipcode, address_city) IS NOT NULL)
;