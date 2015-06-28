#!/bin/bash

echo "-------------------------tcp status count---------------------------"
#TCP状态的列表
#netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'  
/usr/sbin/ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}'

echo "-------------------------check base tcp arguments---------------------------"

sysctl ipv4.tcp_fastopen
sysctl net.ipv4.ip_local_port_range
sysctl net.ipv4.tcp_window_scaling
sysctl net.ipv4.tcp_keepalive_time
sysctl net.ipv4.tcp_keepalive_probes
sysctl net.ipv4.tcp_keepalive_intvl

echo "-------------------------check syn flood---------------------------"

echo -n "client send syn,if not recevie server syn+ack,retry(default 5,3s or 30s？ interval):"
sysctl net.ipv4.tcp_syn_retries
echo ""

echo -n "server send syn+ack,if not recevie client ack,retry(default 5,30s interval):"
sysctl net.ipv4.tcp_synack_retries
echo ""

echo -n "server enable SYN Cookie(1 means enable):"
sysctl net.ipv4.tcp_syncookies
echo ""

echo -n "server max accept queue length(small than /proc/sys/net/core/somaxconn):"
sysctl net.ipv4.tcp_max_syn_backlog
echo -n "/proc/sys/net/core/somaxconn:"
cat /proc/sys/net/core/somaxconn

echo -n "FIN-WAIT-2 time:"
sysctl net.ipv4.tcp_fin_timeout

echo "--------------------------check time_wait-------------------------"

echo -n "enable fast recycling TIME-WAIT sockets(1.net.ipv4.tcp_timestamps should enable 2.recyling time:3.5 RTO):"
sysctl net.ipv4.tcp_tw_recycle
sysctl net.ipv4.tcp_timestamps
echo ""

echo -n "allow to reuse TIME-WAIT sockets for new connections when it is safe from protocol viewpoint(last segment over 1s):"
sysctl net.ipv4.tcp_tw_reuse
echo ""

echo -n "control time_awit connections number:(not in common use）"
sysctl ipv4.tcp_max_tw_buckets

echo "-------------------------check buffer-----------------------------"

echo "is adjust receiver buffer enable(1 means enable):"
sysctl net.ipv4.tcp_moderate_rcvbuf

echo -n "max receive window:"
sysctl net.core.rmem_max
echo ""

echo -n "max send window:"
sysctl net.core.wmem_max
echo ""

sysctl net.ipv4.tcp_rmem 
sysctl net.ipv4.tcp_wmem 
sysctl net.core.netdev_max_backlog 
sysctl net.ipv4.tcp_mtu_probing

echo "-------------------------check tcp rtp-----------------------------"
echo -n "-------------rtt/rvg-------------"
ip tcp_metrics

echo -n "-------------rto-------------"
ss -eipn 


echo -n "congest  modules list:"
sysctl net.ipv4.tcp_available_congestion_control







