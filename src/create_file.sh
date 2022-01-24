#!/bin/bash
# Script: create_file.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
#   Script qui crée le fichier à envoyer ultérieurement via scp.
#
#
#
echo "---> Creating file.." | tee -a $1
ls -la > $2 | tee -a $1
cat $2 | tee -a $1