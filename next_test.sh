#!/bin/bash

# ************************************************************
# NEXT_TEST.SH
# Prepares and runs a test, recycling completed tests if there
# are no more tests to run
# ************************************************************


testdir=$(ls /vagrant/remote/tests | head -n 1)

if [ "$testdir" == "" ]; then
	echo "No tests remaining. Resetting tests."
	mv /vagrant/remote/tests_completed/* /vagrant/remote/tests/
	#echo "test_active	FALSE" > /vagrant/remote/settings
else
	# /vagrant/remote/tests/$testdir/configuretest.sh
	echo "Test found. Preparing."
	rm -f /vagrant/remote/current_test/*
	rm -f /vagrant/remote/settings
	rm -f /vagrant/remote/clientstatus
	cp /vagrant/remote/tests/$testdir/* /vagrant/remote/current_test/
	mv /vagrant/remote/tests/$testdir /vagrant/remote/tests_completed/$testdir
	echo "Configuring test."
	/vagrant/remote/current_test/configuretest.sh
	echo "Executing test."
	/vagrant/remote/scripts/cmdstep.sh
fi