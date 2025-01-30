#!/bin/bash

echo "I'm running on "`hostname -f`
echo "OSG site: $OSG_SITE_NAME"
echo "GLIDEIN_ResourceName: $GLIDEIN_ResourceName"

echo
echo

env 

# also want it to a file based on the resourcename
GLIDEIN_ResourceName=$(echo "$GLIDEIN_ResourceName" | sed 's/ /_/g')
if [ "x$GLIDEIN_ResourceName" == "x" ]; then
    GLIDEIN_ResourceName=$(echo "$OSG_SITE_NAME" | sed 's/ /_/g')
fi
if [ "x$GLIDEIN_ResourceName" == "x" ]; then
    GLIDEIN_ResourceName="UNKNOWN"
fi
env >${GLIDEIN_ResourceName}.env

echo
echo

cat $_CONDOR_MACHINE_AD

# are we on a GPU node?
if [ -n "$CUDA_VISIBLE_DEVICES" ] && \
   [ "$CUDA_VISIBLE_DEVICES" != "10000" ]; then

    echo
    echo

    nvidia-smi

    echo
    echo
    
    nvidia-smi -L
    
    echo
    echo
    
    python3 test-pytorch.py 2>&1

fi

sleep 5m

