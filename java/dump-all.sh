#!/bin/bash
if [ "x${JAVA_HOME}" == "x" ]; then
	echo "error,can not get jav home"	
	exit
fi
NOW=$(date '+%Y%m%d-%H%M%S') 
PID=$1

if [ ! -n "$1" ] ;then
    echo "error!please input java pid"
    exit
fi

echo "JAVA_HOME=${JAVA_HOME}" echo "PID=${PID}"

echo "iostat 1 5"
iostat -k 1 5 > iostat.${NOW}

echo "free"
free -m > free.${NOW}

echo "netstat"
netstat -apn > netstat.${NOW}

echo "ps -aux"
ps -aux > ps.${NOW}

echo "w"
w > w.${NOW}

echo "jstack"
${JAVA_HOME}/bin/jstack ${PID} > stack.${NOW}

echo "histo"
${JAVA_HOME}/bin/jmap -histo:live ${PID} > histo.${NOW}

echo "jstat -gc 1000 5"
${JAVA_HOME}/bin/jstat -gc ${PID} 1000 5 > jstat-gc.${NOW}

echo "dump finish"
