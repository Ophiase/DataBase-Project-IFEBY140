\! echo ---------------------
\! echo - sub_event ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS sub_event CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE
    sub_event (
        child_event_id INT UNIQUE,
        parent_event_id INT,
        --
        PRIMARY KEY (child_event_id, parent_event_id),
        FOREIGN KEY (parent_event_id, child_event_id)
            REFERENCES event_table(event_id, event_id)
    );
