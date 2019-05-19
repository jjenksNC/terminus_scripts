#!/bin/bash
alias terminus=./terminus/vendor/bin/terminus

# Get input from user
echo "Enter the site slug for the site you wish to work with [Example: bloomscape, btm-mx, womens-forum]:"

read siteName

# Ensure the connection is properly set
terminus connection:set $siteName.dev sftp
