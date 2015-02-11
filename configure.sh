#!/bin/bash

# ************************************************************
# CONFIGURE.SH
# Configure settings file to store environment variables for
# a new test
# ************************************************************


# Configurable values
description="fail"
num_clients="fail"
num_iterations="fail"
data_size="fail"

# Necessary inital values
current_iteration="0"
test_id=$(date +%s)


while getopts d:c:i:s: opt; do
	case $opt in
		d)
			description=$OPTARG
		;;
		c)
			num_clients=$OPTARG
		;;
		i)
			num_iterations=$OPTARG
		;;
		s)
			data_size=$OPTARG
		;;
	esac
done

if [ "$description" == "fail" ] || [ "$num_clients" == "fail" ] || [ "$num_iterations" == "fail" ] || [ "$data_size" == "fail" ] || ((num_clients > 4)); then
	echo "specify [-d description] and [-c number_of_clients (must be 1-4)] and [-i number_of_iterations] and [-s data_size_mb]"
	exit
fi

# Example code to replace settings individually in case whole settings file can't be written in one go
# sed -i "s/.*settingname.*/settingname	$settingname/" settings

# Create and fill new settings file
echo "description	$description" > /vagrant/remote/settings
echo "data_size	$data_size" >> /vagrant/remote/settings
echo "num_clients	$num_clients" >> /vagrant/remote/settings
echo "num_iterations	$num_iterations" >> /vagrant/remote/settings
echo "current_iteration	$current_iteration" >> /vagrant/remote/settings
echo "test_id	$test_id" >> /vagrant/remote/settings
echo "test_active	TRUE" >> /vagrant/remote/settings

# To read settings:
# sed 'LINENUMq;d' settings | awk '{ print $2 }'
# where LINENUM is the line of the file to get the setting for
# or
# grep -e SETTING settings | awk '{ print $2 }'
# where SETTING is the name of the setting being read


mkdir -p /vagrant/remote/data/$description/$test_id