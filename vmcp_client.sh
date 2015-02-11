#!/bin/bash

# Run a specified command on $num virtual machines, not including the server

data="fail"
num=4

while getopts d:n: opt; do
	case $opt in
		d)
			data=$OPTARG
		;;
		n)
			num=$OPTARG
		;;
	esac
done

if [ "$data" == "fail" ] || ((num > 4)); then
	echo "specify [-d data] and [-n number_of_clients (must be 1-4)]"
	exit
fi

for ((i=6;i<=(num+5);i++));do
	echo "@vm$(($i-4)) (client $(($i-5))):"
	scp $data vagrant@192.168.1.11$i:~/data_in
	echo
done