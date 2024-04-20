# DataBase-Project-IFEBY140

## Introduction

University project.
Read [report](XXX_YYY_report.pdf) for more details.

## Execution

### Report
```bash
make render # update XXX_YYY_report.pdf
make render_show # update XXX_YYY_report.pdf and open it
make web_preview # start web server and open web report
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