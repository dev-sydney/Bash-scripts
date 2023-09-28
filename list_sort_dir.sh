#!/bin/bash

#$1 - directory name
#$2 - list order (a or d)

#check if the number of arguments
if [[ $# -lt 1 ]]
then
	echo "Sorry, you must provide at least one argument..."
	exit
fi

sorting_order=""

case $1 in
	"-a"|"-d")
		if [[ $1 == "-d" ]]
		then
			sorting_order="-r"
		fi

		echo "Listing & sorting contents in this directory"
		echo "------------------------------------"
		sleep 1

		ls -lh ./ | sort $sorting_order -f -k9
		;;
	*)
		if [[ -d "$1/" ]]
		then
			if [[ $2 == "-d" ]]
			then
				sorting_order="-r"
			fi

			echo "Listing & sorting contents in $1"
			echo "--------------------------------"
			sleep 1

			ls -lh "$1/" | sort $sorting_order -f -k9
		else
			echo "$1 directory not found❗"
		fi
esac
