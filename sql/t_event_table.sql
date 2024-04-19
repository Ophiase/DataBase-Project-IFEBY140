\! echo ---------------------
\! echo - event ...
\! echo ---------------------

\set length_url 512
\set length_title 256
\set length_description 4096

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS event_table CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    event_table (
        event_id SERIAL PRIMARY KEY,
        --
        event_url VARCHAR(:length_url) NOT NULL UNIQUE,
        title VARCHAR(:length_title) NOT NULL,
        lead_text VARCHAR(:length_description),
        --
        date_begin TIMESTAMP DEFAULT NULL,
        date_end TIMESTAMP DEFAULT NULL,
        --
        event_description TEXT, 
        cover_url VARCHAR(:length_url), 
        cover_alt VARCHAR(:length_description), 
        cover_credit VARCHAR(:length_description), 
        --
        address_name VARCHAR(:length_address), 
        address_street VARCHAR(:length_address), 
        address_zipcode VARCHAR(:length_address), 
        address_city VARCHAR(:length_address), 
        --
        price_type VARCHAR(:length_description), 
        price_detail VARCHAR(:length_description), 
        access_type VARCHAR(:length_description), 
        access_link TEXT, 
        access_link_text VARCHAR(:length_description), 
        updated_at TIMESTAMP, 
        image_couverture VARCHAR(:length_url), 
        programs VARCHAR(:length_description), 
        title_event VARCHAR(:length_title), 
        audience VARCHAR(:length_description), 
        --
        contact_url VARCHAR(:length_url), 
        contact_phone VARCHAR(:length_url), 
        contact_mail VARCHAR(:length_url), 
        contact_facebook VARCHAR(:length_url), 
        contact_twitter VARCHAR(:length_url), 
        --
        address_url VARCHAR(:length_url), 
        address_url_text VARCHAR(:length_description), 
        address_text VARCHAR(:length_description),
        --
        group_name VARCHAR(:length_description)
        --
        CONSTRAINT date_coherence 
            CHECK (
                date_end IS NULL OR  
                date_begin IS NULL OR 
                date_end >= date_begin),

        FOREIGN KEY (address_name, address_street, address_zipcode, address_city)
        REFERENCES address_table(address_name, address_street, address_zipcode, address_city)
    );
