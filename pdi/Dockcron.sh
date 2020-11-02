#!/bin/bash

Docker()
{
docker container run --network=rnmonitor_ipca_rnetwork --rm -v $(pwd):/jobs pdirn runj jobs/ETL_RNMONITOR.kjb
}

Checking()
{
checkpost=$(ps -eaf | grep postgres | grep -v grep | wc -l)
if [[ $checkpost -ge 1 ]];then
    echo "*******************"
    echo "POSTGRES IS RUNNING"
    echo "*******************"
else
    echo "***************************************"
    echo "PLEASE START POSTGRES, ETL WILL NOT RUN"
    echo "                                       "
    echo " type docker-compose up postgres       "
    echo "***************************************"
    exit 1
fi
}

Check()
{
Checking
Docker
}

prog_name=${0##*/}

usage=$(printf "\nPLease use the Script as:\n"; printf "\n sh $prog_name \n\n")

if [[ $# -ge 1 ]];then
     echo "${prog_name} : YOU HAVE ENTERED INCORRECT ARGUMENTS "
     echo "${prog_name} : $usage "
     echo "${prog_name} : EXITING PROGRAM"
     exit
  else
     Check
fi
