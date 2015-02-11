#!/bin/bash

# ************************************************************
# REQUESTTESTRUN.SH
# Scheduled script that checks if a test run is currently in
# progress, and starts a new run if none is currently active.
# ************************************************************


# Check current status
test_active=$(grep -e test_active /vagrant/remote/settings | awk '{ print $2 }')

if [ "$test_active" == "FALSE" ]; then
	/vagrant/remote/scripts/next_test.sh
fi