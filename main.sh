#!/bin/bash
# Script: main.sh
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
FILENAME=test.txt
LOGFILE=$DATA/script.log

CKSUM=""

USERNAME=projet

case $HOSTNAME in
	"serveur")
		IP=client
		;;
	"client")
		IP=serveur
		;;
	*)
		IP=serveur
		;;
esac

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

# Function to read keyboard from user
read_option(){
 local option
 read -p "| Option (1-7) --------------------> " option
 case $option in
  1) 
		$SRC/create_file.sh $LOGFILE $FILENAME
		wait;;
  2) 
		$SRC/validate.sh $LOGFILE $FILENAME
		wait ;;
  3) 
	  echo "---> Creating CKSUM file..." | tee -a $LOGFILE
		CHECKSUM=`$SRC/cksum.sh $LOGFILE 0 $FILENAME`
		echo "cksum = $CHECKSUM" | tee -a $LOGFILE
		wait ;;
  4) 
		$SRC/send.sh $LOGFILE $USERNAME $IP $FILENAME
		wait ;;
	5)
		$SRC/cksum.sh $LOGFILE 1 $FILENAME $CKSUM $USERNAME $IP
		wait ;;
  6) viewLog ;;
  7) sortir ;;
  *) echo ERROR ;;
esac

}

################
#Run the program

if [ ! -d $DATA ]
then
	mkdir $DATA
	echo "<--- Create data folder" | tee -a $LOGFILE
fi

while true
do
 show_menu
 read_option
done
