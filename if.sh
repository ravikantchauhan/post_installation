#!/bin/bash
NUM_PROCS=$(ps -e | sed 1d | wc -l)
var4="$(mysql -V | awk '{print $3'})"
# echo "$NUM_PROCS"
if [[ $var4 > 0 ]]; then
   	echo " this is mysql $var4" 
   	exit 1
else
	#Update and Upgrade
	echo "mysqlnot found"
	# apt-get update && sudo apt-get upgrade -y
fi