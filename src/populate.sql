\! echo ---------------------
\! echo - Populate ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS temp_event CASCADE;

-----------------------------------------------------------------
-- EXTRACT CSV

\! echo "EXTRACT FROM CSV"

CREATE TEMPORARY TABLE temp_event (
    event_id INT PRIMARY KEY,
    --
    event_url VARCHAR(:length_url) NOT NULL UNIQUE,
    title TEXT NOT NULL,
    lead_text VARCHAR(:length_description),
    event_description TEXT,
    --
    date_begin TIMESTAMP DEFAULT NULL,
    date_end TIMESTAMP DEFAULT NULL,
    --
    occurrence_date TEXT,  
    date_description VARCHAR(:length_description),
    --
    cover_url VARCHAR(:length_url), 
    cover_alt VARCHAR(:length_description), 
    cover_credit VARCHAR(:length_description),
    --
    keyword VARCHAR(:length_description), 
    --
    address_name VARCHAR(:length_address), 
    address_street VARCHAR(:length_address), 
    address_zipcode VARCHAR(:length_address), 
    address_city VARCHAR(:length_address), 
    --
    geographic_coordinate TEXT,
    --
    pmr BOOLEAN,
    blind BOOLEAN,
    deaf BOOLEAN,
    --
    transport TEXT,
    --
    contact_url VARCHAR(:length_url), 
    contact_phone VARCHAR(:length_url), 
    contact_mail VARCHAR(:length_url), 
    contact_facebook VARCHAR(:length_url), 
    contact_twitter VARCHAR(:length_url), 
    --
    price_type VARCHAR(:length_description), 
    price_detail VARCHAR(:length_description), 
    access_type VARCHAR(:length_description), 
    access_link TEXT, 
    access_link_text VARCHAR(:length_description), 
    updated_at TIMESTAMP, 
    image_couverture VARCHAR(:length_url), 
    programs VARCHAR(:length_description), 
    --
    address_url VARCHAR(:length_url), 
    address_url_text VARCHAR(:length_description), 
    address_text VARCHAR(:length_description),
    --
    title_event VARCHAR(:length_title), 
    audience VARCHAR(:length_description), 
    --
    children TEXT,
    group_name TEXT
    );

\COPY temp_event FROM 'que-faire-a-paris-.csv' DELIMITER ';' CSV HEADER;

-- \COPY temp_event(
--     event_id, title, event_description, event_url, 
--     date_begin, lead_text, date_description, date_end, 
--     cover_url, occurrence_date, cover_credit, keyword, 
--     cover_alt, address_name, address_zipcode, 
--     address_street, address_city, blind, 
--     geographic_coordinate, pmr, deaf, contact_phone, 
--     transport, contact_facebook, contact_url, 
--     contact_mail, price_detail, contact_twitter, 
--     access_link, price_type, updated_at, access_type, 
--     programs, access_link_text, address_url, 
--     image_couverture, address_text, title_event, 
--     address_url_text, audience, children
-- ) FROM 'que-faire-a-paris-.csv' DELIMITER ';' CSV HEADER;


/*
table creation order :

t_geographic_correspondance.sql
t_address.sql

t_event_table.sql

t_occurrence.sql
t_tag.sql
t_sub_event.sql
t_transport.sql

*/

-----------------------------------------------------------------

/* TODO:
    \! echo "---"
    \! echo "[1NF transformation]"
    -- • LIST
        -- occurrences : separated by ’_’ (underscore)
        -- Tags : separated by ‘,’
        -- Childrens : separated by ‘,’
        -- Transport : separated by '\n'

    -- • MULTIPLE ATTRIBUTES
        -- Transport : transport_type, transport_line, station, distance
        -- Geographic_Coordinates : longitude, latitude
*/

-----------------------------------------------------------------
\! echo POPULATE: geographic_correspondance


INSERT INTO geographic_correspondance (
    address_street, address_zipcode, address_city, lat, lon
)
SELECT
    address_street,
    address_zipcode,
    address_city,
    CAST(split_part(geographic_coordinate, ',', 1) AS FLOAT) AS lat,
    CAST(split_part(geographic_coordinate, ',', 2) AS FLOAT) AS lon
FROM temp_event
WHERE address_street IS NOT NULL -- TODO find address using geocode 
ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
\! echo POPULATE: address_table

INSERT INTO address_table (
    address_name, address_street, address_zipcode, address_city,
    pmr, blind, deaf
)
SELECT address_name, address_street, address_zipcode, address_city,
    (CASE
        WHEN pmr = 't' THEN TRUE
        WHEN pmr = 'f' THEN FALSE
        ELSE NULL
    END) AS pmr, 
    (CASE
        WHEN blind = 't' THEN TRUE
        WHEN blind = 'f' THEN FALSE
        ELSE NULL
    END) AS blind,
    (CASE
        WHEN deaf = 't' THEN TRUE
        WHEN deaf = 'f' THEN FALSE
        ELSE NULL
    END) AS deaf
FROM temp_event
WHERE 
    (address_name, address_street, address_zipcode, address_city) 
    IS NOT NULL
ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
\! echo POPULATE: event_table

INSERT INTO event_table(
    event_id, event_url, title, event_description,
    date_begin, lead_text, date_end, 
    cover_url, cover_credit, 
    cover_alt, address_name, address_zipcode, 
    address_street, address_city,
    contact_phone, contact_facebook, contact_url, 
    contact_mail, price_detail, contact_twitter, 
    access_link, price_type, updated_at, access_type, 
    programs, access_link_text, address_url, 
    image_couverture, address_text, title_event, 
    address_url_text, audience, group_name
) SELECT
    event_id, event_url, title, event_description, 
    date_begin, lead_text, date_end, 
    cover_url, cover_credit, 
    cover_alt, address_name, address_zipcode, 
    address_street, address_city,
    contact_phone, contact_facebook, contact_url, 
    contact_mail, price_detail, contact_twitter, 
    access_link, price_type, updated_at, access_type, 
    programs, access_link_text, address_url, 
    image_couverture, address_text, title_event, 
    address_url_text, audience, group_name
FROM temp_event
WHERE
    (
        date_end IS NULL OR  
        date_begin IS NULL OR 
        date_end >= date_begin
    );

-----------------------------------------------------------------
\! echo POPULATE: occurrence

INSERT INTO occurrence (event_id, occurrence_date)
SELECT 
    et.event_id, 
    to_timestamp(
        unnest(string_to_array(occurrence_date, '_')), 
        'YYYY-MM-DD"T"HH24:MI:SS.ff3"Z"'
    ) AS occurrence_date
FROM 
    temp_event
    RIGHT JOIN event_table et 
    ON temp_event.event_id = et.event_id
ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
\! echo POPULATE: tag

INSERT INTO tag (event_id, keyword)
SELECT 
    et.event_id, 
    unnest(string_to_array(keyword, ',')) 
    AS keyword
FROM 
    temp_event
    RIGHT JOIN event_table et 
    ON temp_event.event_id = et.event_id
WHERE
    keyword IS NOT NULL
ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
\! echo POPULATE: sub_event

UPDATE event_table
SET parent_event_id = (
    SELECT
        event_id AS parent_event_id
    FROM (
        SELECT 
            event_id, 
            unnest(string_to_array(children, ';')) AS child
        FROM temp_event
        WHERE
            children IS NOT NULL AND LENGTH(children) > 2
    ) AS t
    WHERE
    (
        CAST(
            substring(
            child,
            (length(child) - position('-' IN reverse(child)) + 2),
            position('-' IN reverse(child)) - 2
            ) 
        AS INT) = event_table.event_id
    )
    LIMIT 1
);

-----------------------------------------------------------------
\! echo POPULATE: transport

\i p_transport.sql

-----------------------------------------------------------------
\i XXX_YYY_anomalies.sql