\! echo ---------------------
\! echo - event ...
\! echo ---------------------

\set length_url 256
\set length_title 128
\set length_description 1024

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
        date_begin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        date_end TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
