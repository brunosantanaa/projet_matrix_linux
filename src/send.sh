#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: ScriptBash transferFile via SFTP
# $1 -> Remote user
# $2 -> IP
# $3 -> File name
#sftp <user>@<hostIP>
# put <fileName>
# quit
#

echo "---> Validating file..." | tee -a $1
sftp $1@$2 << SOMEDELIMITER
 put $3
 quit
SOMEDELIMITER | tee -a $1
