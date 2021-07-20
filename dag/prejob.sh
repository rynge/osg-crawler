#!/bin/bash

#env | sort > tmp.env

# expected directories
mkdir -p envs outputs

# cleanup
find . -name .LOG_.\* -mtime +2 -exec rm {} \;
find outputs -type f -mtime +2 -exec rm {} \;

MAX_HISTORY=$(cat max-history.txt | head -n 1)

REQS=$(cat base-requirements.txt | head -n 1)
ITB_SITES=False
if (echo "$REQS" | grep "Is_ITB_Site == True") >/dev/null 2>&1; then
    ITB_SITES=True
fi

for FILE in $(find outputs -name \*.out | sort -r | head -n $MAX_HISTORY); do
    # extract the resource the job ran at
    RESOURCE=$(cat $FILE | grep "^GLIDEIN_ResourceName: " | sed 's/GLIDEIN_ResourceName: //')
    if [ "x$RESOURCE" != "x" ]; then
        REQS="$REQS && GLIDEIN_ResourceName != \"$RESOURCE\""
    fi
done

# write out a new job submit file
cat >job.sub <<EOF
universe     = vanilla

requirements = $REQS
+ITB_Sites = $ITB_SITES

executable   = job.sh
arguments    =
input        =
output       = outputs/\$(Cluster).out
error        = outputs/\$(Cluster).err
log          = outputs/\$(Cluster).log

should_transfer_files   = YES
when_to_transfer_output = ON_EXIT

request_cpus = 1
request_memory = 1GB

Notification = never

+ProjectName = "OSG-Staff"

queue 
EOF

