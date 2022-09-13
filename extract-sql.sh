#!/bin/bash

# Default option values
HELP=0
OUTPUT_FILE="extract.sql"

function printHelp() {
	echo ""
	echo -e "\033[0;37mThis bash script searches for a given SQL query in a given file, and extracts it."
	echo ""
	echo -e "\033[0;36mUsage:\033[0;37m"
	echo -e "\t./extract_sql.sh [-h|--help] [-q|--query=query] [-i|--input=input_file] [-o|--o=output_file]"
	echo ""
	echo -e "\033[0;36mOptions:\033[0;37m"
	echo -e "\t-h, --help"
	echo -e "\t\t\033[0;0mDisplay this menu\033[0;37m"
	echo ""
	echo -e "\t-q, --query"
	echo -e "\t\tRequired. \033[0;0mThe keyword to look for in the specified file\033[0;37m"
	echo ""
	echo -e "\t-i, --input"
	echo -e "\t\tRequired. \033[0;0mThe file to search into\033[0;37m"
	echo ""
	echo -e "\t-o, --output"
	echo -e "\t\t\033[0;0mThe file to write the result into\033[0;37m"
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
      		echo -e "\033[0;31mERROR\033[0;37m: Unknown option $i"
	  		printHelp
      		exit 1
      		;;
    	*)
			echo -e "\033[0;31mERROR\033[0;37m: Unexpected value $i"
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
	echo -e "\033[0;31mERROR\033[0;37m: The [-q|--query] option is required"
	printHelp
	exit 3
fi

if [ -z "$INPUT_FILE" ]; then 
	echo -e "\033[0;31mERROR\033[0;37m: The [-i|--input] option is required"
	printHelp
	exit 3
fi

# Checks if the input option is a valid file
if [ ! -f "$INPUT_FILE" ]; then
	echo -e "\033[0;31mERROR\033[0;37m : input is not a file"
	printHelp
	exit 3
fi

tr '\n' ' ' < "$INPUT_FILE" | grep -oE "$QUERY .*?; " > "$OUTPUT_FILE"

exit $?
