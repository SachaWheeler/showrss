#!/bin/bash

# Configuration
# https://showrss.info/user/39003.rss?magnets=true&namespaces=false
XML_URL="https://showrss.info/user/39003.rss?magnets=true&namespaces=false"
LOG_FILE="downloaded_links.log"

# Fetch the XML file
curl -s "$XML_URL" -o temp.xml

# Parse the XML file for links
links=$(xmllint --xpath '//link' temp.xml | sed 's/ link="/\n/g' | sed 's/"//g' | tail -n +2)

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# Check each link and add to Transmission if not already added
for link in $links; do
    if ! grep -q "$link" "$LOG_FILE"; then
        echo "Adding $link to Transmission..."
        magnet_link=$(echo "$link" | sed -e 's/^<[^>]*>//' -e 's/<[^>]*>$//')
        magnet=$(urldecode "$magnet_link")
        url=$(echo "$magnet" | sed 's/&amp;/\&/g')
        echo "$url"
        echo
        transmission-remote -a "$url"
        echo "$link" >> "$LOG_FILE"
    else
        echo "$link already added."
    fi
done

# Cleanup
rm temp.xml

