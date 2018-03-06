#!/bin/bash

DATE=$(date +"%Y%m%d")
IFS=$(.)

for file in $(ls -1 $1)
do
    printf "$file\n"
    read -ra filename_array <<< "$file"
done
