#!/bin/bash

echo "I'm running on "`hostname -f`
echo "OSG site: $OSG_SITE_NAME"
echo "GLIDEIN_ResourceName: $GLIDEIN_ResourceName"

echo
echo

env 

# also want it to a file based on the resourcename
GLIDEIN_ResourceName=$(echo "$GLIDEIN_ResourceName" | sed 's/ /_/g')
env >${GLIDEIN_ResourceName}.env

echo
echo

sleep 5m

