#!/bin/bash

# Variables:
# Name of our server
SERVER={{ ansible_hostname }}
# Name of our server
PORT={{ port_es }}
# The amount of snapshots we want to keep.
LIMIT=7
# Name of our snapshot repository
REPO=backup

SNAPSHOT=`date +%Y%m%d-%H%M%S`
curl -XPUT "$SERVER:$PORT/_snapshot/backup/$SNAPSHOT?wait_for_completion=true"

# Get a list of snapshots that we want to delete
SNAPSHOTS=`curl -s -XGET "$SERVER:$PORT/_snapshot/$REPO/_all" \
  | jq -r ".snapshots[:-${LIMIT}][].snapshot"`

# Loop over the results and delete each snapshot
for SNAPSHOT in $SNAPSHOTS
do
 echo "Deleting snapshot: $SNAPSHOT"
 curl -s -XDELETE "$SERVER:$PORT/_snapshot/$REPO/$SNAPSHOT?pretty"
done
echo "Done!"
