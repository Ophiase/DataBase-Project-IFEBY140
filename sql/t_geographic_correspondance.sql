\! echo ---------------------
\! echo - geographic_correspondance ...
\! echo ---------------------

\set length_address 64

-----------------------------------------------------------------
-- CLEAN

DROP TABLE IF EXISTS geographic_correspondance CASCADE;

-----------------------------------------------------------------
-- TABLES

CREATE TABLE geographic_correspondance (
    address_street VARCHAR(:length_address), 
    address_zipcode VARCHAR(:length_address), 
    address_city VARCHAR(:length_address),
    lat FLOAT,
    lon FLOAT,

    PRIMARY KEY (address_street, address_zipcode, address_city)
);