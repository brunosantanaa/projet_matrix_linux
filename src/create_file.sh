#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
#
#
#
#
echo "---> Creating file.." | tee -a $1
ls -la > $2 | tee -a $1