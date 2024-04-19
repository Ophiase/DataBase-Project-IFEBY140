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
        children_event_id INT UNIQUE PRIMARY KEY,
        parent_event_id INT,
        --
        FOREIGN KEY (children_event_id)
            REFERENCES event_table(event_id),
        FOREIGN KEY (parent_event_id)
            REFERENCES event_table(event_id)
    );
