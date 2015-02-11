#!/bin/bash

# ************************************************************
# CLIENTSIDESEED.SH
# Gets torrent data from server and seeds it
# ************************************************************

# Get the number of clients for the current test
scp 192.168.1.115:/vagrant/remote/torrents/test.data.torrent ~/torrent_in
scp 192.168.1.115:/vagrant/remote/inputs/test.data ~/torrents

transmission-remote -a ~/torrent_in/test.data.torrent -w ~/torrents