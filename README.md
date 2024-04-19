# DataBase-Project-IFEBY140

## Introduction

University project.
Read [report](XXX_YYY_report.pdf) for more information.

## Execution

### Report
```bash
make render # update XXX_YYY_report.pdf
make render_show # update XXX_YYY_report.pdf and open it
make web_preview # start web server and open web report
```

### SQL

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
\i XXX_YYY_tables.sql
```

## Planning

TODO :
- Session 1 : 14/04
    - a.1 to a.4
- Session 2 : 15/04
    - (a.5) E/R schema
- Session 3 : 16/04
    - a.6 to a.7 : XXX_YYY_modelisation.pdf
- Session 4 : 18/04
    - (b) implementation : XXX_YYY_tables.sql
- Session 5 : 19/04
    - (c) populate tables : XXX_YYY_tables.sql, XXX_YYY_anomalies.sql
- Session 6 : 20/04
    - (d) script to consult data : XXX_YYY_data.sql