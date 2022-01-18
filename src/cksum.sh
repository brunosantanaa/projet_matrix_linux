#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 17/01/2022
# Description: 
#
#
#
#

echo "---> Creating CKSUM file..."
SHA_SERVEUR=`ssh $1@$2 "sha256sum $3"`
SHA_CLIENT=`sha256sum $3`

if [ SHA_SERVEUR = SHA_CLIENT ]
then
  echo "Transfert effectué avec succès"
else
  echo "Il y a peut-être eu une erreur dans le transfert"
fi