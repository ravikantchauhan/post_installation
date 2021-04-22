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
	         2 "No- keep PHP $(php -v | grep cli | awk '{print $2'}) "
	         3 "Install LAMP stack" off)
			 
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Sublime Text 3*
				echo "Unistalling PHP $(php -v | grep cli | awk '{print $2'}) "
				sudo apt-get -y purge 'php*'
				sudo apt-get autoclean
				sudo apt-get autoremove -y
				;;

			2)
			    	#Install LAMP stack
				echo "Please wait"
				;;
			3)  	#Install LAMP stack
				echo "Installing Apache"
				apt install apache2 -y
				#####
				echo "Please Enter php-verions? "
				read php_versin
				########
				sudo apt install -y python-software-properties
				sudo add-apt-repository ppa:ondrej/php
				sudo apt-get update
				#Install php
				echo "Installing php$dead_app"
				sudo apt install -y php$dead_app
				sudo apt-get install -y $dead_app-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common}
				service apache2 restart
				##########
	            
    			echo "Installing Mysql Server"
    				wget  https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb 
				sudo dpkg -i mysql-apt-config_0.8.16-1_all.deb 
				sudo apt update
				sudo apt install mysql-server -y
				sudo apt install mysql-workbench-community -y

        		echo "Installing Phpmyadmin"
				apt install phpmyadmin -y

				echo "Cofiguring apache to run Phpmyadmin"
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
				echo "Restarting Apache Server"
				service apache2 restart
				;;	
    	    esac
	done
fi
##########

