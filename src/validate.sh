#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
#
#
#
#

echo "---> Validating file..." | tee -a $1

if [ -e $2 ]; then
	if [ -f $2 ]; then
		echo "Is a regular file" | tee -a $1
	elif [ -d $2 ]; then
		echo "Is a directory" | tee -a $1
	fi
else
	echo "File does not exists" | tee -a $1
fi
