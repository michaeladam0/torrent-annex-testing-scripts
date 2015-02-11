#!/bin/bash

# ************************************************************
# CLIENTSIDEDONE.SH
# Executes cleanup and statistics actions after torrent is
# completed
# ************************************************************


# Get IP Address
ip=$(ifconfig eth1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')

# Report Completed Transfer to Server
ssh 192.168.1.115 /vagrant/remote/scripts/clientstep.sh -c $ip