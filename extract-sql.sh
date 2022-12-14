#!/bin/bash

# Default option values
HELP=0
OUTPUT_FILE="extract.sql"
VERSION="v1.0.1"

# Color values
BASE_COLOR="\033[0;37m"
RED_COLOR="\033[0;31m"
CYAN_COLOR="\033[0;36m"

TAB="\t"

function printHelp() {
	echo ""
	echo -e "${BASE_COLOR}This bash script searches for every occurences of a given SQL query in a given file, and extracts them to another file."
	echo ""
	echo -e "${CYAN_COLOR}Usage:${BASE_COLOR}"
	echo -e "${TAB}./extract-sql.sh [-h|--help]"
	echo ""
	echo -e "${TAB}./extract-sql.sh [-v|--version]"
	echo ""
	echo -e "${TAB}./extract-sql.sh [-q|--query=query] [-i|--input=input_file] [-o|--output=output_file]"
	echo ""
	echo -e "${CYAN_COLOR}Options:${BASE_COLOR}"
	echo -e "${TAB}-h, --help"
	echo -e "${TAB}${TAB}Display this menu"
	echo ""
	echo -e "${TAB}-v, --version"
	echo -e "${TAB}${TAB}Display the version of the script"
	echo ""
	echo -e "${TAB}-q, --query"
	echo -e "${TAB}${TAB}Required. The keyword to look for in the specified file"
	echo ""
	echo -e "${TAB}-i, --input"
	echo -e "${TAB}${TAB}Required. The file to search into"
	echo ""
	echo -e "${TAB}-o, --output"
	echo -e "${TAB}${TAB}The file to write the extracted result in. By default, the file name is '${OUTPUT_FILE}'."
}

function printVersion() {
	echo $VERSION
}

# Loop that parses the args / options of the command
for i in "$@"; do
	case $i in
		-h|--help)
			printHelp
			exit 0
      		;;
		-v|--version)
			printVersion
			exit 0
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
      		echo -e "${RED_COLOR}ERROR${BASE_COLOR}: Unknown option $i"
	  		printHelp
      		exit 1
      		;;
    	*)
			echo -e "${RED_COLOR}ERROR${BASE_COLOR}: Unexpected value $i"
	  		printHelp
      		exit 2
      		;;
	esac
done

# query and input are required options
if [ -z "$QUERY" ]; then 
	echo -e "${RED_COLOR}ERROR${BASE_COLOR}: The [-q|--query] option is required"
	printHelp
	exit 3
fi

if [ -z "$INPUT_FILE" ]; then 
	echo -e "${RED_COLOR}ERROR${BASE_COLOR}: The [-i|--input] option is required"
	printHelp
	exit 3
fi

# Checks if the input option is a valid file
if [ ! -f "$INPUT_FILE" ]; then
	echo -e "${RED_COLOR}ERROR${BASE_COLOR} : input is not a file"
	printHelp
	exit 3
fi

tr "\n" ' ' < "$INPUT_FILE" | tr "\r" ' ' | grep -oE "$QUERY .*?; " > "$OUTPUT_FILE"

exit $?
