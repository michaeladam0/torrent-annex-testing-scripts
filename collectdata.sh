#!/bin/bash
#Start bandwidth recording
	ifstat -i eth1 -n > bandwidthstats.log&

#Record initial transfer stats
	
#Packets in:
	echo -n "start_packets_received " > datastats.log
	ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9- >> datastats.log
#Packets out:
	echo -n "start_packets_transmitted " >> datastats.log
	ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9- >> datastats.log

#Bytes in:
	echo -n "start_bytes_received " >> datastats.log
	ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7- >> datastats.log
#Bytes out:
	echo -n "start_bytes_transmitted " >> datastats.log
	ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7- >> datastats.log

#Wait for 10 seconds
	sleep 10

#Record final transfer stats
	
#Packets in:
	echo -n "end_packets_received " >> datastats.log
	ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9- >> datastats.log
#Packets out:
	echo -n "end_packets_transmitted " >> datastats.log
	ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9- >> datastats.log

#Bytes in:
	echo -n "end_bytes_received " >> datastats.log
	ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7- >> datastats.log
#Bytes out:
	echo -n "end_bytes_transmitted " >> datastats.log
	ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7- >> datastats.log

##END

#End bandwidth recording
	sudo pkill ifstat