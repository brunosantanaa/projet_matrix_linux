#!/bin/bash
# Script Projet from Linux Class Matrix College.
# by Kevin Bruno Mario
# Date: 24/01/2022

###
#Variables
PWD=$(pwd)
SRC+=$PWD/src
DATA+=$PWD/data
fileName=fichierTransfer.txt
logFile=$DATA/script.log

serverUser=matrix1-serveur
IP=server

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
	echo "| 5. View Log                              |"
	echo "| 6. Exit                                  |"
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
		$SRC/create_file.sh $logFile $fileName | tee -a $logFile
		wait;;
  2) 
		$SRC/validate.sh $logFile $fileName | tee -a $logFile
		wait ;;
  3) 
		$SRC/cksum.sh  | tee -a $logFile
		wait ;;
  4) 
		$SRC/send.sh $logFile $serverUser $IP $fileName | tee -a $logFile
		wait ;;
  5) viewLog ;;
  6) sortir ;;
  *) echo ERROR ;;
esac

}

###
#Function to visualise log
viewLog(){
	echo "---> View log: "$logFile | tee -a $logFile
	cat $logFile 
	wait
}
###
#Function to exit the program
sortir(){
	echo "---> Exiting..." | tee -a $logFile
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
