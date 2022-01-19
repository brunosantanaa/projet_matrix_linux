#!/bin/bash
# Script: instalation.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 19/01/2022
# Description: 
# 
#
#
#

# Instalation des packages
sudo apt-get install -y git openssh-server 

# Créez l'utilisateur projet

# Chaque machine
case $HOSTNAME in
  "serveur")
    sudo adduser projet
    su projet -
    ssh-keygen
  ;;
  "client")
    sudo adduser projet
    su projet -
    ssh-copy-id projet@server
  ;;
  *)
    echo "non configuré"
    ;;
esac