#!/bin/bash

#directory path of which we want to take backup
source_dir=$1 

#directory path where we want to place backup file
target_dir=/home/ansar/backup

#current time stamp for identifying recent file
current_time=$(date "+%Y-%m-%d-%H-%M-%S")

#backup file as a variable  
backup_file=$target_dir/backup_$current_time.tgz

#taking backup and compressing it zip
tar czf $backup_file --absolute-names $source_dir 

echo "backup completed"

#removing older file"

#checking number of files in a backup directory
check="$(ls /home/ansar/backup/ | wc -l)"

if [[ $check>=3 ]] ;         #if number of files in backup directory are greater than 3 it will remove old file
then
	cd /home/ansar/backup/
	rm "$(ls -t | tail -n 1)"
fi
