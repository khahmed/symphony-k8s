#!/bin/sh
SYM_TOP=/opt/ibm/spectrumcomputing
CLUSTERADMIN=egoadmin
HOSTNAME=`hostname`

/bin/su -c "source $SYM_TOP/profile.platform; egoconfig join $MASTERNAME -f" egoadmin
if [ "$MASTERNAME" == `hostname` ]; then
    cat /var/tmp/cfc/key1.dat >> /tmp/license.dat
    sed -i -e '$a\' /tmp/license.dat
    cat /var/tmp/cfc/key2.dat >> /tmp/license.dat
    /bin/su -c "source $SYM_TOP/profile.platform; egoconfig mghost /shared -f; egoconfig setentitlement /tmp/license.dat" egoadmin
fi

# Our scripts use uname -a to figure out the platform they are running on. Docker doesn't virtualize that so it reports the 
# host OS. If the host OS is Ubuntu and Sym container is CentOS scripts get confused
source $SYM_TOP/profile.platform

chown  $CLUSTERADMIN $SYM_TOP/kernel/work 
chgrp  $CLUSTERADMIN $SYM_TOP/kernel/work 
egosh ego start

i=1
while [ "$i" -ne 0 ]
do
   sleep 10
done

