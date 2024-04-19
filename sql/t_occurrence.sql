\! echo ---------------------
\! echo - occurrence ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS occurrence CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    occurrence (
        event_id INT,
        occurrence_date TIMESTAMP,
        --
        PRIMARY KEY (event_id, occurrence_date),
        FOREIGN KEY (event_id)
            REFERENCES event_table(event_id)
    );
