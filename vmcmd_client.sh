#!/bin/bash

# Run a specified command on $num virtual machines, not including the server

cmd="fail"
num=4

while getopts c:n: opt; do
	case $opt in
		c)
			cmd=$OPTARG
		;;
		n)
			num=$OPTARG
		;;
	esac
done

if [ "$cmd" == "fail" ] || ((num > 4)); then
	echo "specify [-c command] and [-n number_of_clients (must be 1-4)]"
	exit
fi

for ((i=6;i<=(num+5);i++));do
	#echo "### $cmd for vm$(($i-4)) ###"
	echo "@vm$(($i-4)) (client $(($i-5))):"
	ssh vagrant@192.168.1.11$i $cmd
	echo
done