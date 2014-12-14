#!/bin/sh
usage()
{
    echo "usage: `basename $0` start|stop ip"
}       

if [ $# -lt 1  ]; then
    usage
    exit 1
fi

OPT=$1
case $OPT in 
        start) echo "Starting Route"
        WHAT="add"
        ;;
        stop) echo "Stoping Route"
        WHAT="delete"
        ;;
        *)usage
        ;;
esac

#OLDGW=`netstat -nr | grep '^default' | grep -v 'ppp' | sed 's/default *\([0-9\.]*\) .*/\1/'`
if [ -n "$2" ]
then
    OLDGW=$2
else
    OLDGW=`netstat -nr | grep '^default' | grep -v 'ppp' | awk '{if(NR==1) print $2'}`
fi

echo "old gateway is "$OLDGW

route $WHAT -net 10.10.8  "${OLDGW}"
route $WHAT -net 10.10.10 "${OLDGW}" 
route $WHAT -net 10.14.17 "${OLDGW}"

