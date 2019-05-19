#!/bin/bash

# Get input from user
echo "Enter the site slug for the site you wish to work with [Example: bloomscape, btm-mx, womens-forum]:"

read siteName

echo "What plugin would you like to install?"

read pluginName

echo "Push to live?"

read liveBool

# Ensure the connection is properly set
error_exit()
{
	echo "$1" 1>&2
	exit 1
}

if terminus connection:set $siteName.dev sftp; then
	terminus remote:wp $siteName.dev -- plugin install $pluginName
        terminus env:commit $siteName.dev --note "installing $pluginName"
	terminus env:deploy $siteName.test --message "deploying $pluginName"
	terminus env:deploy $siteName.live -- message "deploying $pluginName"
	terminus remote:wp $siteName.dev -- plugin activate $pluginName
	terminus remote:wp $siteName.test -- plugin activate $pluginName
else 
	error_exit "Connection Setting Failed! Aborting."
fi
