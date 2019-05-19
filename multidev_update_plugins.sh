#!/bin/bash

now=$(date +"%m-%Y");
multidev_name="pup"$now;

# Get input from user
echo "Enter the site slug for the site you wish to work with [Example: bloomscape, btm-mx, womens-forum]:";

read siteName;

# Ensure the connection is properly set
error_exit()
{
	echo "$1" 1>&2
	exit 1
}

if terminus multidev:create $siteName.live $multidev_name; then
	terminus connection:set $siteName.$multidev_name sftp
	terminus remote:wp $siteName.$multidev_name -- plugin update --all
	terminus remote:wp $siteName.$multidev_name -- core update 
	terminus env:clear-cache $siteName.$multidev_name	
else 
	error_exit "Connection Setting Failed! Aborting."
fi
