#!/bin/sh
export SYM_TOP=/opt/ibm/spectrumcomputing
export CLUSTERADMIN=egoadmin
export HOSTNAME=`hostname`

# patch to support kernel 4
sed -i 's|$version = "3"|$version = "3" -o $version = "4"|g' ${SYM_TOP}/kernel/conf/profile.ego

/bin/su -c "source $SYM_TOP/profile.platform; egoconfig join $MASTERNAME -f" egoadmin
if [ "$MASTERNAME" == `hostname` ]; then
    cat /var/tmp/cfc/key1.dat >> /tmp/license.dat
    sed -i -e '$a\' /tmp/license.dat
    cat /var/tmp/cfc/key2.dat >> /tmp/license.dat
    /bin/su -c "source $SYM_TOP/profile.platform; egoconfig mghost /shared -f; source $SYM_TOP/profile.platform; egoconfig setentitlement /tmp/license.dat" egoadmin
fi

source $SYM_TOP/profile.platform

chown  $CLUSTERADMIN $SYM_TOP/kernel/work 
chgrp  $CLUSTERADMIN $SYM_TOP/kernel/work 
egosh ego start

i=1
while [ "$i" -ne 0 ]
do
   sleep 10
done

