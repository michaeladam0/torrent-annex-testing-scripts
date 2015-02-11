#!/bin/bash

# ************************************************************
# GETCLIENTRESULTS.SH
# Retrieves transfer statistics for the given number of
# clients
# ************************************************************

# Get the number of clients for the current test
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Variables to determine where to save client data
description=$(grep -e description /vagrant/remote/settings | awk '{ print $2 }')
test_id=$(grep -e test_id /vagrant/remote/settings | awk '{ print $2 }')
current_iteration=$(grep -e current_iteration /vagrant/remote/settings | awk '{ print $2 }')

# Get and save results from clients
for ((i=6;i<=(num_clients+5);i++));do
	client_id="192.168.1.11$i"
	sudo mkdir -p /vagrant/remote/data/$description/$test_id/$current_iteration/$client_id
	scp $client_id:~/results/* /vagrant/remote/data/$description/$test_id/$current_iteration/$client_id/
done