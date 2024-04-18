\! echo ---------------------
\! echo - address_table ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS address_table CASCADE;

-----------------------------------------------------------------
-- TABLES

\! echo "Warning, TODO: foreign key for the primary key"

CREATE TABLE address_table (
    address_name VARCHAR(:length_address), 
    address_street VARCHAR(:length_address), 
    address_zipcode VARCHAR(:length_address), 
    address_city VARCHAR(:length_address),
    pmr BOOLEAN,
    blind BOOLEAN,
    deaf BOOLEAN,

    PRIMARY KEY (address_name, address_street, address_zipcode, address_city),

    -- CONSTRAINT fk_event_address
    --     FOREIGN KEY (address_name, address_street, address_zipcode, address_city)
    --     REFERENCES event_table(address_name, address_street, address_zipcode, address_city),

    CONSTRAINT useful_row CHECK (
        pmr IS NOT NULL OR 
        blind IS NOT NULL OR
        deaf IS NOT NULL
    )
);
