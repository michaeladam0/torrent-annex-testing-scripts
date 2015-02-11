#!/bin/bash

# ************************************************************
# DATACOLLECTSTART.SH
# Saves initial stats for the current test and initiates
# bandwidth monitoring
# ************************************************************


# Variables to determine where to save stat data
description=$(grep -e description /vagrant/remote/settings | awk '{ print $2 }')
test_id=$(grep -e test_id /vagrant/remote/settings | awk '{ print $2 }')
current_iteration=$(grep -e current_iteration /vagrant/remote/settings | awk '{ print $2 }')

mkdir -p /vagrant/remote/data/$description/$test_id/$current_iteration

#Initiate bandwidth recording
	ifstat -i eth1 -n > /vagrant/remote/data/$description/$test_id/$current_iteration/serverbandwidthstats.log&

#Record initial time
	echo -n "initial_time " > /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
	date +%s.%N >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log

#Record initial transfer stats
	
#Packets in:
	echo -n "initial_packets_received " >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
	ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9- >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
#Packets out:
	echo -n "initial_packets_transmitted " >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
	ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9- >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log

#Bytes in:
	echo -n "initial_bytes_received " >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
	ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7- >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
#Bytes out:
	echo -n "initial_bytes_transmitted " >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log
	ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7- >> /vagrant/remote/data/$description/$test_id/$current_iteration/servergeneralstats.log