\! echo ---------------------
\! echo - tag ...
\! echo ---------------------

\set length_keyword 64

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS tag CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    tag (
        event_id INT,
        keyword VARCHAR(:length_keyword),
        --
        PRIMARY KEY (event_id, keyword),
        FOREIGN KEY (event_id)
            REFERENCES event_table(event_id)
    );
