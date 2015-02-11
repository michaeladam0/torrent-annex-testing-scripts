#!/bin/bash

# ************************************************************
# CLIENTSTEP.SH
# Called by client when returning upon transfer completion
# Calls runtestsecondstage.sh when all clients have returned
# ************************************************************


# Variables to identify client and overall client status
num_clients=$(grep -e num_clients /vagrant/remote/settings | awk '{ print $2 }')

# Increment and get client complete count
echo "client_returned" >> /vagrant/remote/clientstatus
clients_complete=$(grep -e client_returned /vagrant/remote/clientstatus | wc -l)

if ((clients_complete >= num_clients)); then
	echo "All clients returned."
	rm -f /vagrant/remote/clientstatus
	/vagrant/remote/current_test/runtestsecondstage.sh
else
	if [ "$(grep -e alternate_ran /vagrant/remote/clientstatus | awk '{ print $2 }')" == "FALSE" ]; then
		sed -i "s/.*alternate_ran.*/alternate_ran	TRUE/" /vagrant/remote/clientstatus
		/vagrant/remote/current_test/runtestalternatestage.sh
	fi
fi
