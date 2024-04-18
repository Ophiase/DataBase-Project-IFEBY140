\! echo ---------------------
\! echo - geographic_correspondance ...
\! echo ---------------------

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS geographic_correspondance CASCADE;

-----------------------------------------------------------------
-- TABLES

\! echo "Warning, TODO: foreign key for the primary key"

CREATE TABLE geographic_correspondance (
    address_street VARCHAR(:length_address), 
    address_zipcode VARCHAR(:length_address), 
    address_city VARCHAR(:length_address),
    lat FLOAT NOT NULL,
    lon FLOAT NOT NULL,

    PRIMARY KEY (address_street, address_zipcode, address_city)

    -- FOREIGN KEY (address_street, address_zipcode, address_city)
    -- REFERENCES event_table(address_name, address_street, address_zipcode, address_city)
);