#!/bin/bash

# ************************************************************
# CLIENTDATACOLLECTSTART.SH
# Client-side version of DATACOLLECTSTART.SH
# Saves initial stats for the current test and initiates
# bandwidth monitoring
# ************************************************************

mkdir -p ~/results

#Get IP
ip=$(ifconfig eth1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')

#Initiate bandwidth recording
	ifstat -i eth1 -n > ~/results/bandwidthstats.$ip.log&

#Record initial time
	echo -n "initial_time " > ~/results/generalstats.$ip.log
	date +%s.%N >> ~/results/generalstats.$ip.log

#Record initial transfer stats
	
#Packets in:
	echo -n "initial_packets_received " >> ~/results/generalstats.$ip.log
	ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9- >> ~/results/generalstats.$ip.log
#Packets out:
	echo -n "initial_packets_transmitted " >> ~/results/generalstats.$ip.log
	ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9- >> ~/results/generalstats.$ip.log

#Bytes in:
	echo -n "initial_bytes_received " >> ~/results/generalstats.$ip.log
	ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7- >> ~/results/generalstats.$ip.log
#Bytes out:
	echo -n "initial_bytes_transmitted " >> ~/results/generalstats.$ip.log
	ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7- >> ~/results/generalstats.$ip.log