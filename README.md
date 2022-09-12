# Extract SQL

## Introduction

This project is a simple bash script that can extract an `INSERT INTO` instruction into a specific table, from a SQL dump.

The extracted intruction is then written in a file called `extract.sql`.

## Usage 

To use the script : 

```bash
Usage : ./extract_sql.sh table_name sql_file
```

To display the help :

```bash
./extract_sql.sh -h
```
