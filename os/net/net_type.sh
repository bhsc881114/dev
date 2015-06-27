#TCP状态的列表
#netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'  
/usr/sbin/ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}'

