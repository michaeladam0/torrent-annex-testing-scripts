#!/bin/bash

# ************************************************************
# CLIENTDATACOLLECTEND.SH
# Client-side version of DATACOLLECTEND.SH
# Saves final stats for the current test and ends bandwidth
# monitoring
# ************************************************************

#Record final transfer stats	
#Packets in:
	echo -n "final_packets_received " >> ~/results/generalstats.log
	ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9- >> ~/results/generalstats.log
#Packets out:
	echo -n "final_packets_transmitted " >> ~/results/generalstats.log
	ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9- >> ~/results/generalstats.log

#Bytes in:
	echo -n "final_bytes_received " >> ~/results/generalstats.log
	ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7- >> ~/results/generalstats.log
#Bytes out:
	echo -n "final_bytes_transmitted " >> ~/results/generalstats.log
	ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7- >> ~/results/generalstats.log

#Record final time
	echo -n "final_time " >> ~/results/generalstats.log
	date +%s.%N >> ~/results/generalstats.log

#End bandwidth recording
	sudo pkill ifstat