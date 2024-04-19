\! echo ---------------------
\! echo - Populate ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS temp_event CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TEMPORARY TABLE temp_event (
    event_id SERIAL PRIMARY KEY,
    --
    event_url VARCHAR(:length_url) NOT NULL UNIQUE,
    title TEXT NOT NULL,
    lead_text VARCHAR(:length_description),
    event_description TEXT, 
    --
    date_begin TIMESTAMP DEFAULT NULL,
    date_end TIMESTAMP DEFAULT NULL,
    --
    occurence_date TEXT,  
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
    childrens TEXT,
    which_group TEXT
    );

\COPY temp_event FROM 'que-faire-a-paris-.csv' DELIMITER ';' CSV HEADER;

-- \COPY temp_event(
--     event_id, title, event_description, event_url, 
--     date_begin, lead_text, date_description, date_end, 
--     cover_url, occurence_date, cover_credit, keyword, 
--     cover_alt, address_name, address_zipcode, 
--     address_street, address_city, blind, 
--     geographic_coordinate, pmr, deaf, contact_phone, 
--     transport, contact_facebook, contact_url, 
--     contact_mail, price_detail, contact_twitter, 
--     access_link, price_type, updated_at, access_type, 
--     programs, access_link_text, address_url, 
--     image_couverture, address_text, title_event, 
--     address_url_text, audience, childrens
-- ) FROM 'que-faire-a-paris-.csv' DELIMITER ';' CSV HEADER;
