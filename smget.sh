#!/usr/bin/env bash

ip=$1
username=$2
#Passwords containing a %!* need to be escaped
password=$3
#Set to SMB/Samba port number
port=445
#Name of the folder to save downloads to
saveFolder="smbloot"
#If the number of files on the share is greater than or equal to this value,
#the program will give the user an option to skip downloading that share.
fileLimit=5

printbanner () {
  echo "          __  ___ ______ ______ ______"
  echo "   _____ /  |/  // ____// ____//_  __/"
  echo "  / ___// /|_/ // / __ / __/    / /"
  echo " (__  )/ /  / // /_/ // /___   / /"
  echo "/____//_/  /_/ \____//_____/  /_/"
  echo
  echo "Created by jakesss"
}

printhelp () {
  echo "A smbclient/smbmap wrapper that recusively downloads files from readable SMB/Samba shares on a client"
  echo
  echo "Syntax: sMGET client [username] [password]"
  echo
  echo "Options:"
  echo
  echo "  client      IP/domain name of the client"
  echo "  username    Username to authenticate to the share with (optional)"
  echo "  password    Password to authenticate to the share with (optional)"
  echo "  -h/--help   Show this help prompt"
  echo
  echo "Examples:"
  echo
  echo "  sMGET 192.168.1.1                    Uses null authentication"
  echo "  sMGET 192.168.1.1 jakesss Pass123!   Authenticates w/ username and password"
  echo
  echo "Don't forget to check the source code for other script arguments!"
  echo
  exit 1
}

printMessage () {
  #echo  "===================================================================================="
  echo -e "\033[1;35m"$1"\033[0m"
  #echo "====================================================================================="
}

nullAuth () {
  printbanner

  #Checks if output folder exists
  if [ ! -d "$PWD/$saveFolder" ]
  then
    mkdir "$PWD/$saveFolder"
  fi
  folderPath="$PWD/$saveFolder"

  #Find readable shares
  printMessage "Finding readable shares on $ip"
  readableShares=$(smbmap -H "$ip" -P $port -u anonymous | grep READ | awk '{print $1}')
  echo "$readableShares"

  #Loop over the shares and download the files
  for share in $(echo $readableShares)
  do
    #Check if share folder already exists
    if [ ! -d "$folderPath/$share" ]; then mkdir "$folderPath/$share"; fi

    #Check amount of files on current share
    printMessage "Counting number of files on \\\\\\$ip\\\\$share (This can take a while)"
    totalFiles=$(smbclient \\\\"$ip"\\"$share" -p $port -U "anonymous%' '" -c 'lcd '$folderPath/$share';recurse;prompt;ls' | awk '{if ( NF == 8 && $(NF-6) != "D" ) { print }}' | wc -l)

    if [ $totalFiles -ge $fileLimit ]
    then
      download=" "
      #Asks the user if they wish to download files from a share
      while [ "$download" != "N" ] && [ "$download" != "n" ] && [ "$download" != "y" ] && [ "$download" != "Y" ]
      do
        echo -e "This share has ~$totalFiles files. Proceed to download? [y/n] \c"
        read download
      done
    fi

    if [ "$download" = "n" ] || [ "$download" = "N" ]
    then
      printMessage "Skipping download";
      continue
    fi

    #Download the files
    printMessage "Downloading..."
    smbclient \\\\"$ip"\\"$share" -p $port -U "anonymous%' '" -c 'lcd '$folderPath/$share';recurse;prompt;mget *'

  done

  printMessage "Script finished successfully"
}

credAuth () {
  printbanner

  #Checks if output folder exists
  if [ ! -d "$PWD/$saveFolder" ]
  then
    mkdir "$PWD/$saveFolder"
  fi
  folderPath="$PWD/$saveFolder"

  #Find readable shares
  printMessage "Finding readable shares on $ip"
  readableShares=$(smbmap -H "$ip" -P $port -u "$username" -p "\"$password\"" | grep READ | awk '{print $1}')
  echo "$readableShares"

  #Loop over the shares and download the files
  for share in $(echo $readableShares)
  do
    #Check if share folder already exists
    if [ ! -d "$folderPath/$share" ]; then mkdir "$folderPath/$share"; fi

    #Check amount of files on current share
    printMessage "Counting number of files on \\\\\\$ip\\\\$share (This can take a while)"
    totalFiles=$(smbclient \\\\"$ip"\\"$share" -p $port -U "$username%\"$password\"" -c 'lcd '$folderPath/$share';recurse;prompt;ls' | awk '{if ( NF == 8 && $(NF-6) != "D" ) { print }}' | wc -l)

    if [ $totalFiles -ge $fileLimit ]
    then
      download=" "
      #Asks the user if they wish to download files from a share
      while [ "$download" != "N" ] && [ "$download" != "n" ] && [ "$download" != "y" ] && [ "$download" != "Y" ]
      do
        echo -e "This share has ~$totalFiles files. Proceed to download? [y/n] \c"
        read download
      done
    fi

    if [ "$download" = "n" ] || [ "$download" = "N" ]
    then
      printMessage "Skipping download";
      continue
    fi

    #Download the files
    printMessage "Downloading..."
    smbclient \\\\"$ip"\\"$share" -p $port -U "$username%\"$password\"" -c 'lcd '$folderPath/$share';recurse;prompt;mget *'
  done

  printMessage "Script finished successfully"
}

##### Script Starts #####
# Check command line arguments/display help
if [ $# -lt 1 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]
then
  printhelp
fi

#Check if using null authentication and runs script
if [ $# -lt 2 ]
then
  nullAuth
else
  credAuth
fi
