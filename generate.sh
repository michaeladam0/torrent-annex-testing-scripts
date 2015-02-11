#!/bin/bash

# ************************************************************
# GENERATE.SH
# Outputs random data for a given number of megabytes into
# a generic data file, then creates a torrent for that data
# file
# ************************************************************


# Get the data size
data_size=$(grep -e data_size /vagrant/remote/settings | awk '{ print $2 }')

# Generate the data file
dd if=/dev/urandom of=/vagrant/remote/inputs/test.data bs=$data_size'M' count=1

# Create the torrent file
transmission-create -t udp://192.168.1.115:6969/announce -o /vagrant/remote/torrents/test.data.torrent /vagrant/remote/inputs/test.data