#!/bin/bash

# ************************************************************
# CLEAN.SH
# Remove current transfer from transmission and clean up
# torrent data
# ************************************************************


# Remove torrent from transmission
transmission-remote -t $(transmission-remote -l | tail -n 2 | head -n 1 | awk '{ print $1 }') -r

# Remove all inputs and torrents
#rm -f /vagrant/remote/current_test/*
rm -f /vagrant/remote/torrents/*
rm -f /vagrant/remote/inputs/*