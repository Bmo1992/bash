#!/bin/bash

  ##############################################
  #                                            #
  # Name         : grpcreate                   #
  # Version      : 1.1                         #
  # Author       : Brandon Morgan              #
  # Date         : 06/29/2017                  #
  #                                            #
  # Description  : To create multiple users    #
  #                assign them to a single     #
  #                group, give a default PW    #
  #                to be changed on first      #
  #                login, and add personal     #
  #                details                     #
  #                                            #
  # Last Updated : 06/30/2017                  #
  # Changes      : Fixed Posix-compatibility   #
  #                Issue. Fixed group creation #
  #                issues and followed clean   #
  #                coding standard             #
  #                                            #
  ##############################################   


################### SUBROUTINES ###################

# Check if the specified group exists and create if it doesn't
grpLookup ()
{
    cat /etc/group | cut -d ":" -f1 > /tmp/groupChecker.txt
    
    grep $GROUP /tmp/groupChecker.txt >> /dev/null 2>&1

    if [[ "$?" = 0 ]]; then
        echo "The $GROUP group already exists"
    elif [[ "$?" = 1 ]]; then
        echo "There is currently no $GROUP group"
        echo "Creating the $GROUP group..."
        groupadd $GROUP
        sleep 2
    else
        echo "Something terrible has happened. Blame $GROUP"
        exit
     fi

   # Check for a home directory and create if it doesn't exist
   echo "Now checking if $GROUP has an existing home directory"
     if [ -d /home/$GROUP ]; then
         echo "/home/$GROUP already exists"
     else
         echo "/home/$GROUP does not exist"
         echo "Creating home directory now..."
         mkdir /home/$GROUP
         sleep 2
     fi
}

# Add user, group, temporary password, and set password expiration
makeUsers ()
{
    for ((i=0; $i < ${#USERS[@]}; i++)); 
    do
        echo "Creating ${USER[$i]}"
        sleep 1
        adduser -d /home/$GROUP/${USERS[$i]} ${USERS[$i]} -g $GROUP
        echo $PASSWORD | passwd ${USERS[$i]} --stdin
        chage -d 0 ${USERS[$i]}
    done  >> /dev/null 2>&1
}

# Add the users full name
addNames ()
{
    for ((h=0; $h < ${#USERS[@]}; h++)); 
    do
        echo -n "Add the full name of ${USERS[$h]}: "
        read FNAME
        chfn -f "$FNAME" ${USERS[$h]} >> /dev/null 2>&1
    done 
}

################# Main_Program ##################

# echo version info because vanity
if [[ "$@" = "-v" ]];
then
    echo "grpcreate v1.2 created by Brandon Morgan { yung thug bmo }"
    exit
fi

# Require sudo powers to run
if [ "$UID" != 0 ];
then
    echo "This script requires root privileges $USER"
fi

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

echo
echo -n "What users would you like to add?: "
read -a USERS

echo -n "What group would you like them in?: "
read GROUP
grpLookup

echo -n "Give the new users a default password: "
read -s PASSWORD
printf "\n"
echo "The new users will be required to change this on first login"
echo
 
makeUsers
addNames


unset -f grpLookup makeUsers addNames
