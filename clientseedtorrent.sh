#!/bin/bash

# ************************************************************
# CLIENTSEEDTORRENT.SH
# Orders clients to get and seed the data for the current
# test
# ************************************************************

# Get the number of clients for the current test
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Get and save results from clients
for ((i=6;i<=(num_clients+5);i++));do
	client_id="192.168.1.11$i"

	# Execute removal script on client
	ssh $client_id ~/scripts/clientsideseed.sh
done

/vagrant/remote/current_test/runtestsecondstage.sh