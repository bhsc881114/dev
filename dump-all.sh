#!/bin/bash
NOW=$(date '+%Y%m%d-%H%M%S') 
PID=$1

echo "who"
w > who.${NOW}
echo "======" >> who.${NOW}
last >> who.${NOW}

echo "history"
history > history.${NOW}

echo "iostat 1 5"
iostat -k 1 5 > iostat.${NOW}

echo "free"
free -m > free.${NOW}

echo "netstat"
netstat -apn > net.${NOW}
echo "======" >> net.${NOW}
/usr/sbin/ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}' >> net.${NOW}


echo "ps -aux"
pstree -a > ps.${NOW}
echo "======" >> ps.${NOW}
ps -aux >> ps.${NOW}

echo "interrupts"
cat /proc/interrupts > interrupts.${NOW}

if [ "x${JAVA_HOME}" == "x" ]; then
	echo "error,can not get jav home"	
	exit
fi

if [ ! -n "$1" ] ;then
    echo "error!please input java pid"
    exit
fi

echo "JAVA_HOME=${JAVA_HOME}" 
echo "PID=${PID}"

echo "jstack"
${JAVA_HOME}/bin/jstack ${PID} > stack.${NOW}

echo "histo"
${JAVA_HOME}/bin/jmap -histo:live ${PID} > histo.${NOW}

echo "jstat -gc 1000 5"
${JAVA_HOME}/bin/jstat -gc ${PID} 1000 5 > jstat-gc.${NOW}

echo "dump finish"
