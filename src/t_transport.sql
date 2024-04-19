\! echo ---------------------
\! echo - transport ...
\! echo ---------------------

\set transport_description_length 64

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS transport CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    transport (
        event_id INT,
        transport_type VARCHAR(:transport_description_length),
        transport_line VARCHAR(:transport_description_length),
        station VARCHAR(:transport_description_length),
        distance FLOAT,
        --
        PRIMARY KEY (event_id, transport_type, transport_line, station),
        FOREIGN KEY (event_id)
            REFERENCES event_table(event_id)
    );
