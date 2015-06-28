#!/bin/bash

# syn flood argument

echo "-------------------------check syn flood------------------------------"

sysctl net.ipv4.tcp_syn_retries
sysctl net.ipv4.tcp_synack_retries
sysctl net.ipv4.tcp_syncookies
sysctl net.ipv4.tcp_max_syn_backlog

echo "---------------------------------------------------------------"

