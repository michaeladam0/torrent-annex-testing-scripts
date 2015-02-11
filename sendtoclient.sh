#!/bin/bash

# ************************************************************
# SENDTOCLIENT.SH
# Transfers current torrent data to a specified number of 
# clients
# ************************************************************

# Get the number of clients to receive the torrent file
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Send torrent file to specified number of clients
for ((i=6;i<=(num_clients+5);i++));do
	scp /vagrant/remote/torrents/test.data.torrent vagrant@192.168.1.11$i:~/torrent_in
done

# Initiate transfer and data collection for the specified clients
for ((i=6;i<=(num_clients+5);i++));do
	ssh vagrant@192.168.1.11$i ~/scripts/clientdatacollectstart.sh
	ssh vagrant@192.168.1.11$i transmission-remote -a ~/torrent_in/test.data.torrent -w ~/torrents
done