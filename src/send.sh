#!/bin/bash
#ScriptBash transferFile via SFTP
#Exemple: 
#sftp <user>@<hostIP>
# put <fileName>
# quit
echo "---> Validating file..." | tee -a $1
sftp $1@$2 << SOMEDELIMITER
 put $3
 quit
SOMEDELIMITER | tee -a $1
