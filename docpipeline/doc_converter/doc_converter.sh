#!/bin/bash

# $1 -> file extension to search for; $2 -> source dir; $3 -> output dir;
# file naming convention: dlc-description-<exportnum>-<date>.<ext>
CLIENT="dlc"

# Do not change the delimiter to ' '. You will be hunted down and murdered.
# Thanks! Your cooperation is appreciated.  :)
DELIM="-"
DELIMEXT="."

# Used for versioning.
DATE=$(date +"%Y%m%d")

# Used to exit the script if errors are detected.
ERROR=0

if [[ -z $1 ]]
then
	printf "ERROR: Missing file extension to search for.\n"
	ERROR=1
fi

if [[ -z $2 ]]
then
	printf "ERROR: Missing source directory.\n"
	ERROR=1
fi

if [[ -z $3 ]]
then
	printf "ERROR: Missing output dir.\n"
	ERROR=1
fi

if [[ $ERROR -gt 0 ]]
then
	printf "Exiting.\n"
	exit $ERROR
fi

EXT="docx"

case "$1" in
	md)
		type=markdown
		printf "Type set to Markdown.\n"
		;;
	*)
		printf "ERROR: Unknown input type.\n"
		exit 12
esac

#for file in $(find $2 -maxdepth 1 -type f -name "*.$1")
for file in $(find $2 -type f -name "*.$1")
do
	printf "File path: $file\n"
	file_basename=$(basename "$file")
	dir_basename=$(dirname "$file")
	filename=${file_basename%.*}
	dir_wormhole=${dir_basename#/*/}

	printf "Dir wormhole: $dir_wormhole\n"

    	filename_new="$CLIENT$DELIM$filename$DELIM$DATE$DELIMEXT$EXT"
    	mkdir -p $3/$EXT
	printf "Converting $file to $3/$EXT/$filename_new\n"
    	pandoc -f $type -t docx -sS "$2/$file" -o "$3/$EXT/$filename_new"
done
