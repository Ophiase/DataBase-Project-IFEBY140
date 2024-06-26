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
\! echo "\033[1;33m.--------------------------------------.\033[0m"
\! echo "\033[1;33mI                                      I\033[0m"
\! echo "\033[1;33mI               INIT                   I\033[0m"
\! echo "\033[1;33mI                                      I\033[0m"
\! echo "\033[1;33m.--------------------------------------.\033[0m"
\! echo

-----------------------------------------------------------------
-- Create tables

\i t_geographic_correspondance.sql
\i t_address.sql
\i t_event_table.sql
\i t_occurrence.sql
\i t_tag.sql
\i t_transport.sql

-----------------------------------------------------------------
-- Populate tables

\i populate.sql

-----------------------------------------------------------------
-- Show anomalies

\i XXX_YYY_anomalies.sql
