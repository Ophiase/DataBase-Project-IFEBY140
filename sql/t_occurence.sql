\! echo ---------------------
\! echo - occurence ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS occurence CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    occurence (
        event_id INT,
        occurence_date TIMESTAMP,
        --
        PRIMARY KEY (event_id, occurence_date),
        FOREIGN KEY (event_id)
            REFERENCES event_table(event_id)
    );
