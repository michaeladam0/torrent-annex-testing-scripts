#!/bin/bash

# ************************************************************
# CLIENTDATACOLLECTEND.SH
# Client-side version of DATACOLLECTEND.SH
# Saves final stats for the current test and ends bandwidth
# monitoring
# ************************************************************

#End bandwidth recording
sudo pkill ifstat

#Get IP
ip=$(ifconfig eth1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')

# Determine final statistics
final_packets_received=$(ifconfig eth1 | grep -e 'RX packets' | awk '{ print $2 }' | cut -c 9-)
final_packets_transmitted=$(ifconfig eth1 | grep -e 'TX packets' | awk '{ print $2 }' | cut -c 9-)
final_bytes_received=$(ifconfig eth1 | grep -e 'RX bytes' | awk '{ print $2 }' | cut -c 7-)
final_bytes_transmitted=$(ifconfig eth1 | grep -e 'TX bytes' | awk '{ print $6 }' | cut -c 7-)
final_time=$(date +%s.%N)

# Read initial statistics
initial_time=$(grep -e initial_time ~/results/generalstats.$ip.log | awk '{ print $2 }')
initial_packets_received=$(grep -e initial_packets_received ~/results/generalstats.$ip.log | awk '{ print $2 }')
initial_packets_transmitted=$(grep -e initial_packets_transmitted ~/results/generalstats.$ip.log | awk '{ print $2 }')
initial_bytes_received=$(grep -e initial_bytes_received ~/results/generalstats.$ip.log | awk '{ print $2 }')
initial_bytes_transmitted=$(grep -e initial_bytes_transmitted ~/results/generalstats.$ip.log | awk '{ print $2 }')

# Calculate total statistics
total_time=$(echo "scale=9; $final_time - $initial_time" | bc)
total_packets_received=$((final_packets_received - initial_packets_received))
total_packets_transmitted=$((final_packets_transmitted - initial_packets_transmitted))
total_bytes_received=$((final_bytes_received - initial_bytes_received))
total_bytes_transmitted=$((final_bytes_transmitted - initial_bytes_transmitted))

#Record final transfer stats
#***************************
#Packets in:
	echo "final_packets_received	$final_packets_received" >> ~/results/generalstats.$ip.log
#Packets out:
	echo "final_packets_transmitted	$final_packets_transmitted" >> ~/results/generalstats.$ip.log

#Bytes in:
	echo "final_bytes_received	$final_bytes_received" >> ~/results/generalstats.$ip.log
#Bytes out:
	echo "final_bytes_transmitted	$final_bytes_transmitted" >> ~/results/generalstats.$ip.log

#Final time
	echo "final_time	$final_time" >> ~/results/generalstats.$ip.log
	
#Record total transfer stats
#***************************
echo
echo "total_packets_received	$total_packets_received" >> ~/results/generalstats.$ip.log
echo "total_packets_transmitted	$total_packets_transmitted" >> ~/results/generalstats.$ip.log
echo "total_bytes_received	$total_bytes_received" >> ~/results/generalstats.$ip.log
echo "total_bytes_transmitted	$total_bytes_transmitted" >> ~/results/generalstats.$ip.log
echo "total_time	$total_time" >> ~/results/generalstats.$ip.log