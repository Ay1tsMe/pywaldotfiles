#!/bin/bash

# Query nmcli for an active Ethernet connection
# This looks for connections of type '802-3-ethernet' that are active
eth_info=$(nmcli -t -f NAME,TYPE,DEVICE connection show --active | grep ':802-3-ethernet:')

# If no active Ethernet connection, show “No Ethernet”
if [ -z "$eth_info" ]; then
    echo "󰈁  No Ethernet"
    exit 0
fi

# Extract the connection name (the first field)
eth_name=$(echo "$eth_info" | cut -d':' -f1)

# Optionally, define an icon for Ethernet
eth_icon="󰈁"

# If $show_ssid is true, show the Ethernet connection name
# Otherwise, just show a generic “Connected” label
if [ "$show_ssid" = true ]; then
    echo "$eth_icon $eth_name"
else
    echo "$eth_icon Connected"
fi

