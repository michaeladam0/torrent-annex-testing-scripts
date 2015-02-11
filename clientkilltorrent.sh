#!/bin/bash

# ************************************************************
# CLIENTKILLTORRENT.SH
# Removes torrent and data for the configured number of 
# clients
# ************************************************************

# Get the number of clients for the current test
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Get and save results from clients
for ((i=6;i<=(num_clients+5);i++));do
	client_id="192.168.1.11$i"

	# Execute removal script on client
	ssh $client_id ~/scripts/clientdatacollectend.sh
	ssh $client_id ~/scripts/clientsideremovetorrent.sh
done

