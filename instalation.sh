#!/bin/bash
# Script: instalation.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 19/01/2022
# Description: 
# 
#
#
#

search_ip(){
  echo "A la recherche du $1"
  GAP=3
  
  IP=`ifconfig | grep "inet 192.168" | cut -d" " -f10`
  E_BYTE=`echo $IP | cut -d"." -f4`
  NET=`echo $IP | cut -d"." -f1,2,3`.
  
  MIN=`expr $E_BYTE - $GAP`
  if [ $MIN -lt 2 ] 
  then 
    MIN=2
  fi
  MAX=`expr $E_BYTE + $GAP`
  if [ $MAX -gt 254 ]
  then 
    MAX=254 
  fi
  
  declare -a RESP
  I=0
  for (( V=$MIN ; V <= $MAX ; V++ )) 
  do
    ping $NET$V -c 1 -i 0.2
    if [ $? -eq 0 -a $NET$V != $IP ]; then
      echo "i = $I"
      RESP[$I]=$NET$V
      I=`expr $I + 1`
    fi
  done
  
  I=0
  if [ $RESP[$I] ]
  then
    echo "Choisissez IP $1 dans la liste ou entrez tout autre caractère pour définir une adresse IP."
    for R in ${RESP[@]}
    do
      echo "$I) $R"
      I=`expr $I + 1`
    done
    read RD_IP
    if [ ${RESP[$RD_IP]} ]
    then
      sudo echo -e "${RESP[$RD_IP]}\t$1\n $(</etc/hosts)" > /etc/hosts
    else
      read IP_DEF
      sudo echo -e "$IP_DEF\t$1\n $(</etc/hosts)" > /etc/hosts
    fi
  fi
}

# Instalation des packages
sudo apt-get install -y git openssh-server 

# Créez l'utilisateur projet

# Chaque machine
case $HOSTNAME in
  "serveur")
    sudo useradd -d /home/projet -m projet
    passwd projet < echo -e "\n\n"

    search_ip "client"
    su projet
    cd ~
    ssh-keygen
  ;;
  "client")
    sudo useradd -d /home/projet -s /bin/bash -m projet
    sudo passwd -d projet
    search_ip "serveur"
    su projet
    cd ~
    ssh-copy-id projet@serveur
  ;;
  *)
    echo "Configuration generique"
    sudo useradd -d /home/projet -s /bin/bash -m projet
    sudo passwd -d projet
    search_ip "serveur"
    su projet
    cd ~
    ssh-keygen
    ssh-copy-id projet@serveur
    ;;
esac