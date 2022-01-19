#!/bin/bash
# Script: cksum.sh
# Author: Bruno de Santana | Kevin Clovel | Mario Camelo
# Date: 24/01/2022
# Description: 
#	Script Projet from Linux Class Matrix College.
#
#
#
###
#Variables
PWD=$(pwd)
SRC+=$PWD/src
DATA+=$PWD/data
FILENAME=fichierTransfer.txt
LOGFILE=$DATA/script.log

CKSUM=""

SERVERUSER=matrix1-serveur
IP=server

if [ ! -d data]
do
	mkdir data
fi

###
# Function to VIEW Menu
show_menu(){
	clear
	echo " =========================================="
	echo "|                                          |"
	echo "|                                          |"
	echo "| *** Projet - Introdution au Linux ***    |"
	echo "|                                          |"
	echo "| Équipe 1:                                |"
	echo "|  - Bruno de Santana                      |"
	echo "|  - Kevin Clovel                          |"
	echo "|  - Mario Camelo                          |"
	echo "|                                          |"
	echo " ------------------------------------------"
	echo " =========================================="
	echo "|             *** MENU ***                 |"
	echo " ------------------------------------------"
	echo "|                                          |"
	echo "| 1. Create File                           |"
	echo "| 2. Validate File                         |"
	echo "| 3. Create CKSum                          |"
	echo "| 4. Transfer File                         |"
	echo "| 5. Verifier le Transfer                  |"
	echo "| 6. View Log                              |"
	echo "| 7. Exit                                  |"
	echo "|                                          |"
	echo " ------------------------------------------"
	echo " =========================================="
}

wait(){
	read -p "Enter to cont..." READ
}

# Function to read keyboard from user
read_option(){
 local option
 read -p "| Option (1-6) --------------------> " option
 case $option in
  1) 
		$SRC/create_file.sh $LOGFILE $FILENAME | tee -a $LOGFILE
		wait;;
  2) 
		$SRC/validate.sh $LOGFILE $FILENAME | tee -a $LOGFILE
		wait ;;
  3) 
		CHECKSUM=`$SRC/cksum.sh $LOGFILE 0 $FILENAME` | tee -a $LOGFILE
		wait ;;
  4) 
		$SRC/send.sh $LOGFILE $SERVERUSER $IP $FILENAME | tee -a $LOGFILE
		wait ;;
	5)
		$SRC/cksum.sh $LOGFILE 1 $FILENAME $CKSUM $SERVERUSER $IP | tee -a $LOGFILE
		wait ;;
  6) viewLog ;;
  7) sortir ;;
  *) echo ERROR ;;
esac

}

###
#Function to visualise log
viewLog(){
	echo "---> View log: "$LOGFILE | tee -a $LOGFILE
	cat $LOGFILE 
	wait
}
###
#Function to exit the program
sortir(){
	echo "---> Exiting..." | tee -a $LOGFILE
	clear
	exit 1
}

################
#Run the program
while true
do
 show_menu
 read_option
done
