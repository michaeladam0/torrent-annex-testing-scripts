#!/bin/bash

# ************************************************************
# CLIENTSIDEREMOVETORRENT.SH
# Removes torrent and data for the client
# ************************************************************


# Remove Torrent from Transmission
transmission-remote -t $(transmission-remote -l | tail -n 2 | head -n 1 | awk '{ print $1 }') -r

# Delete Torrent Data
rm -rf ~/torrents/*
rm -rf ~/torrent_in/*