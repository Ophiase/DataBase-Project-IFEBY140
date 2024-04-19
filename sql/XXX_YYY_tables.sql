/*
    Conventions :
        - This file is composed of multiple sql files
            - e_*.sql : execution
            - t_*.sql : table creation
            - p_*.sql : table population
*/

-----------------------------------------------------------------

-- \set name_schema PROJECT
-- DROP SCHEMA IF EXISTS :name_schema CASCADE;
-- CREATE SCHEMA :name_schema;
-- SET search_path TO :name_schema;

-----------------------------------------------------------------

SET client_min_messages TO WARNING;

-- \! cls
\! clear
\! echo
\! echo ".--------------------------------------."
\! echo "I                                      I"
\! echo "I               INIT                   I"
\! echo "I                                      I"
\! echo ".--------------------------------------."
\! echo

-----------------------------------------------------------------

-- \set something 128

-----------------------------------------------------------------
-- Create tables

\i t_geographic_correspondance.sql
\i t_address.sql
\i t_event_table.sql
\i t_occurence.sql
\i t_sub_event.sql
\i t_transport.sql

-----------------------------------------------------------------
-- Populate tables

\i populate.sql