#!/usr/bin/env bash
# $1 is the source directory for the Markdown files. Can be a relative path.
# $2 is the out directory. This needs to be an absolute path at this point in time.

RUNDATETIME=$(date +%F-%T)
SOURCE="$1"
DIR_OUTPUT="$2/single_pdfs-$RUNDATETIME"

printf "$(date +%F:%T) Start of file processing...\n"
printf "\tSource directory: $1\n"
printf "\tOutput directory: $DIR_OUTPUT\n"
printf "\n---------------------\n"


if [[ -d $SOURCE ]] 
then
	mkdir -p $DIR_OUTPUT
	cd $SOURCE

	for file in $(ls . | grep -ve "ZZ" -e attachments -e images | sort -t '-' -k 1 -k 2 -k 3)
	do
		file_name=$(printf "$file" | tr "." "_")
		printf "Processing $file -> $file_name.pdf\t"
		/usr/bin/time -h pandoc --latex-engine=lualatex -sf markdown --template=../template/dlc-custom-latex.template -o $DIR_OUTPUT/$file_name.pdf ../template/metadata.yaml $file
		printf "Done!\n"
	done
elif [[ -f $SOURCE ]]
then
	pathname=$(dirname $SOURCE)
	file=$(basename $SOURCE)
	file_name=$(printf "$file" | tr "." "_")

	mkdir -p $DIR_OUTPUT
	cd $pathname

	printf "Processing $file -> $file_name.pdf\t"

	/usr/bin/time -h pandoc --latex-engine=lualatex -sf markdown --template=../template/dlc-custom-latex.template -o $DIR_OUTPUT/$file_name.pdf ../template/metadata.yaml $file
else
	printf "$1 is not a file or a directory, so not quite sure what to do with it.\nExiting...\n"
fi

printf "$(date +%F:%T) End of file processing.\n"
