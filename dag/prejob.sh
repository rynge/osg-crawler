#!/bin/bash

# expected directories
mkdir -p envs outputs

# cleanup
find . -name .LOG_.\* -mtime +2 -exec rm {} \;
find outputs -type f -mtime +2 -exec rm {} \;

MAX_HISTORY=$(cat max-history.txt | head -n 1)

REQS="True"
for FILE in $(find outputs -name \*.out | sort -r | head -n $MAX_HISTORY); do
    # extract the resource the job ran at
    export RESOURCE=$(cat $FILE | grep "^GLIDEIN_ResourceName: " | sed 's/GLIDEIN_ResourceName: //')
    if [ "x$RESOURCE" != "x" ]; then
        export REQS="$REQS && GLIDEIN_ResourceName != \"$RESOURCE\""
    fi
done

# write out a new job submit file
eval "echo \"$(<job.sub.template)\"" >job.sub

