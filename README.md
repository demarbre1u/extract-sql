# Extract SQL

## Introduction

This bash script searches for a given SQL query in a given file, and extracts it.

## How to use 

```
Usage: 
	./extract_sql.sh [-h|--help] [-q|--query=query] [-i|--input=input_file] [-o|--o=output_file]

Options:
	-h, --help
		Display this menu

	-q, --query
		Required. The keyword to look for in the specified file

	-i, --input
		Required. The file to search into

	-o, --output 
		The file to write the extracted result in
```
