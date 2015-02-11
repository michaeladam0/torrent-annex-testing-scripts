#!/bin/bash

# ************************************************************
# CLIENTINITIATEDATACOLLECTION.SH
# Initiates data collection for the given number of clients
# ************************************************************

# Get the number of clients to receive the torrent file
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Initiate transfer and data collection for the specified clients
for ((i=6;i<=(num_clients+5);i++));do
	ssh vagrant@192.168.1.11$i ~/scripts/clientdatacollectstart.sh
done