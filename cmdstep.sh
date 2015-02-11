#!/bin/bash

# ************************************************************
# CMDSTEP.SH
# Runs the current test until all iterations are exhausted
# ************************************************************


# Get and increment iteration
current_iteration=$(($(grep -e current_iteration /vagrant/remote/settings | awk '{ print $2 }')+1))

# Get iterations cap
num_iterations=$(grep -e num_iterations /vagrant/remote/settings | awk '{ print $2 }')

# Get test descriptor
description=$(grep -e description /vagrant/remote/settings | awk '{ print $2 }')

# Get test id
test_id=$(grep -e test_id /vagrant/remote/settings | awk '{ print $2 }')


# Check if iterations have maxed out yet
if ((current_iteration > num_iterations)); then
	# Iterations are maxed, run next test
	echo "Iterations maxed. Moving to next test."
	/vagrant/remote/scripts/next_test.sh

else
	# Iterations still remaining, increment iterator in settings
	echo "Iterations remaining. Iterating."
	sed -i "s/.*current_iteration.*/current_iteration	$current_iteration/" /vagrant/remote/settings

	# Create dir for next iteration
	mkdir -p /vagrant/remote/data/$description/$test_id/$current_iteration

	# Set clientstatus file
	echo "alternate_ran	FALSE" > /vagrant/remote/clientstatus

	# Run test
	/vagrant/remote/current_test/runtest.sh
fi