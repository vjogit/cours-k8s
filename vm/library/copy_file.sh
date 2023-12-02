#!/bin/bash


#source: https://technekey.com/ansible-custom-module-using-bash-script/
source $1

changed="false"
rc=0
stdout=""
stderr=""
msg=""
failed="false"

file_name=`echo $dest | awk -F '/' '{print $NF}'`
recover_path=`echo $dest | awk -F'/' '{for(i=1; i<NF; i++) printf $i "/"}'`

mkdir -p  $recover_path 

if [[ ! -e "$src/$file_name" ]]; then
    stderr="fichier inexistant: $src/$file_name"
    failed="true"
else 
    cp $src/$file_name $dest
fi

printf "{ \"changed\": \"$changed\",
          \"failed\": $failed,
           \"rc\": \"$rc\" ,
           \"stdout\": \"$stdout\",
           \"stderr\": \"$stderr\"}"
exit $rc

