# DataBase-Project-IFEBY140

## Introduction

A database project for a university course.
For more details : [pdf report](XXX_YYY_report.pdf), [web report](https://ophiase.github.io/DataBase-Project-IFEBY140/)

Course constraint :
> Code everything in psql. \
> Don't use pgsql functions to extract the data.

## Execution

### Report
```bash
make update_pdf # update XXX_YYY_report.pdf and open it
make update_web # update docs/

make preview_web # start web server and open web report
```

### PSQL

Start psql in src folder.
```bash
cd src
psql -d <database> username
```

Create tables and populate them with :
```sql
\i XXX_YYY_tables.sql
```

See a preview of the data with :
```sql
\i XXX_YYY_data.sql
```