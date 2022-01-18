#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
# Example: 
#  Pour générer le checksum
#   cksum.sh 0 <nomefichier>
#  Pour vérifier l'intégrité du fichier transféré
#   cksum.sh 1 <nomefichier> <nomeutilisateurremote> <IP>
#
#

echo "---> Creating CKSUM file..."
case $1
0)
  SHA_CLIENT=`cksum $2 | cut -d" " -f1`
  ;;
1)
  SHA_CLIENT=`cksum $2 | cut -d" " -f1`
  SHA_SERVEUR=`ssh $3@$4 "cksum $2 | cut -d' ' -f1"`
  if [ $SHA_SERVEUR = $SHA_CLIENT ]
  then
    echo "Transfert effectué avec succès"
  else
    echo "Il y a peut-être eu une erreur dans le transfert"
  fi
  ;;
*)
  echo "COMMAND ERROR"
