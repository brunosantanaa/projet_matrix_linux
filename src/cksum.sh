#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
# Example: 
#  Pour générer le checksum
#   cksum.sh <fichierlog> 0 <nomefichier>
#  Pour vérifier l'intégrité du fichier transféré
#   cksum.sh <fichierlog> 1 <nomefichier> <nomeutilisateurremote> <IP>
#
#

case $2 in
0)
  cksum $3 | cut -d" " -f1
  ;;
1)
  echo "---> Compair CKSUM file..." | tee -a $1
  
  SHA_CLIENT=`cksum $3 | cut -d" " -f1` ; cksum $3 | cut -d" " -f1 | tee -a $1
  SHA_SERVEUR=`ssh $4@$5 "cksum $3 | cut -d' ' -f1"` ; ssh $4@$5 "cksum $3 | cut -d' ' -f1" | tee -a $1
  
  echo "FILE = $3" | tee -a $1
  echo "cksum CLIENT = $SHA_CLIENT" | tee -a $1
  echo "cksum SERVER = $SHA_SERVEUR" | tee -a $1
  
  if [ $SHA_SERVEUR = $SHA_CLIENT ]
  then
    echo "Transfert effectué avec succès" | tee -a $1
  else
    echo "Il y a peut-être eu une erreur dans le transfert" | tee -a $1
  fi
  ;;
*)
  echo "COMMAND ERROR" | tee -a $1
 ;;
esac