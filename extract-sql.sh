#!/bin/bash

# Default option values
HELP=0
OUTPUT_FILE="extract.sql"

function printHelp() {
	echo ""
	echo "This bash script searches for a given SQL query in a given file, and extracts it."
	echo ""
	echo "Usage:"
	echo -e "\t./extract_sql.sh [-h|--help] [-q|--query=query] [-i|--input=input_file] [-o|--o=output_file]"
	echo ""
	echo "Options:"
	echo -e "\t-h, --help"
	echo -e "\t\tDisplay this menu"
	echo ""
	echo -e "\t-q, --query"
	echo -e "\t\tRequired. The keyword to look for in the specified file"
	echo ""
	echo -e "\t-i, --input"
	echo -e "\t\tRequired. The file to search into"
	echo ""
	echo -e "\t-o, --output"
	echo -e "\t\tThe file to write the result into"
}

# Loop that parses the args / options of the command
for i in "$@"; do
	case $i in
		-h|--help)
      		HELP=1
      		shift
      		;;
		-q=*|--query=*)
			QUERY="${i#*=}"
      		shift
			;;
    	-i=*|--input=*)
      		INPUT_FILE="${i#*=}"
      		shift
      		;;
		-o=*|--output=*)
      		OUTPUT_FILE="${i#*=}"
      		shift
      		;;
		-*|--*)
      		echo "ERROR: Unknown option $i"
	  		printHelp
      		exit 1
      		;;
    	*)
			echo "ERROR: Unexpected value $i"
	  		printHelp
      		exit 2
      		;;
	esac
done

# Prints help
if [ $HELP -eq 1 ]; then
	printHelp
	exit 0
fi

# query and input are required options
if [ -z "$QUERY" ]; then 
	echo "ERROR: The [-q|--query] option is required"
	printHelp
	exit 3
fi

if [ -z "$INPUT_FILE" ]; then 
	echo "ERROR: The [-i|--input] option is required"
	printHelp
	exit 3
fi

# Checks if the input option is a valid file
if [ ! -f "$INPUT_FILE" ]; then
	echo "ERROR : input is not a file"
	printHelp
	exit 3
fi

tr '\n' ' ' < "$INPUT_FILE" | grep -oE "$QUERY .*?; " > "$OUTPUT_FILE"

exit $?
