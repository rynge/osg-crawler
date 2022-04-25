#!/bin/bash

set -e

find . -maxdepth 1 -name \*.env -exec mv {} envs/  >/dev/null 2>&1 \;
for LOG in $(find . -maxdepth 1 -name .LOG\*); do
    NEW_LOG=outputs/$(echo $LOG | sed 's/^\.//')
    mv $LOG $NEW_LOG
done

# retry
exit 1

