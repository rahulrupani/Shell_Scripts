#!/bin/bash
HOSTS=/tmp/file.csv
TMPO=tmp.out
OUTCSV=output.csv

#Host file is in CSV below are example details
# host1,root,password
# host2,red,passw0rd
# host3,user,pass

for host in `cat $HOSTS |awk -F, '{print $1}'`
    do
        echo $host > $TMPO
        #Defining Credentials 
        USERNAME=`grep $host $HOSTS |awk -F, '{print $2}'`
        PASS=`grep $host $HOSTS|awk -F, '{print $3}'`

        #Getting details
        echo $PASS | ssh $USERNAME@$host "esxcli hardware cpu global get | grep 'CPU Cores' ">> $TMPO
        echo $PASS | ssh $USERNAME@$host "esxcli hardware cpu global get | grep 'CPU Packages' " >> $TMPO

        #Merging the output to CSV file
        paste -sd, $TMPO >> $OUTCSV
done





