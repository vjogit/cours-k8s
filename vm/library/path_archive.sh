#!/bin/bash

source $1

changed="false"
rc=0
stdout=""
stderr=""
msg=""
failed="false"

if [[ $restore == "-" ]]; then
    result=`cd $backup;ls -t  | grep -m 1 ""`
else
    result=$restore
fi

rep="$backup/$result"

if [[ ! -d "$rep" ]]; then
    stderr="Repertoire de sauvegarde non trouve: $rep"
    failed="true"
fi

# Module result
if [[ $result == "" ]]; then
    stderr="Repertoire de sauvegarde non trouve"
    failed="true"
fi

printf "{ \"changed\": \"$changed\",
          \"failed\": $failed,
           \"rc\": \"$rc\" ,
           \"stdout\": \"$stdout\",
           \"stderr\": \"$stderr\",
           \"result\": \"$result\"}"
exit $rc

