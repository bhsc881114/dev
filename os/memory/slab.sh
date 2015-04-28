
 cat /proc/slabinfo |awk '{if($3*$4/1024/1024 > 100){print $1,$3*$4/1024/1024} }'
