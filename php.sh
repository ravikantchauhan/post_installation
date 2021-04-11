#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating "
	#apt-get update
#######

cmd=(dialog --separate-output --checklist "PHP $(php -v | grep cli | awk '{print $2'}) already install:Are youn want uninstall? :" 22 76 16)
	options=(1 "yes uninstall " off    # any option can be set to default to "on"
	         2 "No- keep PHP $(php -v | grep cli | awk '{print $2'}) " off)
			 
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Sublime Text 3*
				echo "Unistalling PHP $(php -v | grep cli | awk '{print $2'}) "
				sudo apt-get purge php*
				sudo apt-get autoclean
				sudo apt-get autoremove -y
				;;

			2)
			    	#Install LAMP stack
				echo "Please wait"
				;;
    	    esac
	done
fi
##########
sudo apt install -y python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
######	
	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select php version to need install:" 22 76 16)
	options=(1 "PHP 5.6" off    # any option can be set to default to "on"
	         2 "PHP 7.0" off
	         3 "PHP 7.1" off
	         4 "PHP 7.2" off
	         5 "PHP 7.3" off
	         6 "PHP 7.4" off
	         7 "PHP 8.0" off)
			 
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Sublime Text 3*
				echo "Installing php5.6"
				sudo apt -y install php5.6
				;;

			2)
			    	#Install LAMP stack
				echo "Installing php7.0"
				sudo apt install -y php7.0
				sudo apt-get install -y php7.0-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;
    			3)
    						#Install Build Essentials
				echo "Installing php7.1"
				sudo apt install -y php7.1
				sudo apt-get install -y php7.1-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;
				
			4)
				#Install Nodejs
				echo "Installing php7.2"
				sudo apt install -y php7.2
				sudo apt-get install -y php7.2-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;

			5)
				#Install git
				echo "Installing php7.2"
				sudo apt install -y php7.3
				sudo apt-get install -y php7.3-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;
			6)
				#Install git
				echo "Installing php7.4"
				sudo apt install -y php7.4
				sudo apt-get install -y php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;
			7)
				#Install git
				echo "Installing php8.0"
				sudo apt install -y php8.0
				sudo apt-get install -y php8.0-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				;;

	    esac
	done
fi
