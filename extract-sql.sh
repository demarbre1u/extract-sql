#!/bin/bash

if [ ! $1 ]
then
	echo "ERROR : No table name specified"
	echo "Usage : ./extract_sql.sh table_name sql_file"
	exit 1
fi

if [ $# -eq 1 -a $1 = "-h" ]
then
	echo "Usage : ./extract_sql.sh table_name sql_file"
	exit 0
fi

if [ ! $2 ]
then
	echo "ERROR : No file specified"
	echo "Usage : ./extract_sql.sh table_name sql_file"
	exit 2
fi


if [ ! -f $2 ]
then
	echo "ERROR : ARG2 is not a file"
	echo "Usage : ./extract_sql.sh table_name sql_file"
	exit 3
fi

sed -n "/INSERT INTO \`$1\`/p" $2 > extract.sql

exit 0
