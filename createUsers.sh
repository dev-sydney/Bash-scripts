#!/bin/bash
num_created_users=1

function createUsers(){
	#prompt for user name
	read -p "Please enter a user name to get started: " user_name

	#check if that user already exists
	#create one if user doesn't exist
	if [[ -z $(cut -d: -f1 /etc/passwd | grep -w "$user_name") ]]
	then
		read -s -p "Please enter a password for $user_name: " user_passwd
		echo ""
		
		read -p "Please enter a number of days until the account is deactived: " active_days
		
		read -p "Add a comment? (press ENTER to skip) " user_comment

		sudo useradd -m -d /home/$user_name -s /bin/bash -p $(openssl passwd -1 $user_passwd) -e $(date -d "+$active_days days" +%Y-%m-%d) -c "$user_comment " $user_name
	#throw an error if they exist
	else
		echo "An account with the username $user_name already exists.❗"
	fi
	

}

#loop until they enter 'n' to stop the loop

while [[ true ]]
do
	createUsers

	read -p "Do you want to create another user? (y/n) " answer

	if [[ "$answer" == "y" || "$answer" == "Y" ]]
	then
		$((num_created_users=num_created_users+1))
		continue
	elif [[ "$answer" == "n" || "$answer" == "N" ]]
	then
		echo "Newly created users"
		echo "-------------------"
		sleep 1

		tail -n$num_created_users /etc/passwd | cut -d: -f1

		break
	fi
done
