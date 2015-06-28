#!/bin/bash

#TCP状态的列表
#netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'  
/usr/sbin/ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}'


sysctl ipv4.tcp_fastopen


# syn flood argument

echo "-------------------------check syn flood------------------------------"

echo "client send syn,if not recevie server syn+ack,retry(default 5,30s interval):\c"
sysctl net.ipv4.tcp_syn_retries

echo "after server send syn+ack,if not recevie ack,retry(default 5,30s interval):\c"
sysctl net.ipv4.tcp_synack_retries

echo "server enable SYN Cookie(1 means enable):\c"
sysctl net.ipv4.tcp_syncookies

echo "server max accept queue length(small than  /proc/sys/net/core/somaxconn):\c"
sysctl net.ipv4.tcp_max_syn_backlog
echo "/proc/sys/net/core/somaxconn:\c":
cat /proc/sys/net/core/somaxconn

echo "---------------------------------------------------------------"
sysctl net.ipv4.tcp_tw_recycle
sysctl ipv4.tcp_max_tw_buckets

sysctl net.ipv4.tcp_tw_reuse

echo "-------------------------check buffer-----------------------------"

sysctl net.core.rmem_max
sysctl net.core.wmem_max
sysctl net.ipv4.tcp_rmem 
sysctl net.ipv4.tcp_wmem 
sysctl net.core.netdev_max_backlog 
sysctl net.ipv4.tcp_mtu_probing

echo "-------------------------check tcp rtp-----------------------------"

sysctl net.ipv4.tcp_available_congestion_control
