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
				echo "Installing Apache"
				apt install apache2 -y
	            
    			echo "Installing Mysql Server"
	 			apt install mysql-server -y

        		echo "Installing PHP"
				apt install php libapache2-mod-php php-mcrypt php-mysql -y
	            
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



######	
	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select php version to need install:" 22 76 16)
	options=(1 "Sublime Text 3" off    # any option can be set to default to "on"
	         2 "LAMP Stack" off
	         3 "Build Essentials" off
	         4 "Node.js" off
	         5 "Git" off)
			 
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Sublime Text 3*
				echo "Installing Sublime Text"
				add-apt-repository ppa:webupd8team/sublime-text-3 -y
				apt update
				apt install sublime-text-installer -y
				;;

			2)
			    	#Install LAMP stack
				echo "Installing Apache"
				apt install apache2 -y
	            
    			echo "Installing Mysql Server"
	 			apt install mysql-server -y

        		echo "Installing PHP"
				apt install php libapache2-mod-php php-mcrypt php-mysql -y
	            
        		echo "Installing Phpmyadmin"
				apt install phpmyadmin -y

				echo "Cofiguring apache to run Phpmyadmin"
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
				echo "Restarting Apache Server"
				service apache2 restart
				;;
    		3)	
				#Install Build Essentials
				echo "Installing Build Essentials"
				apt install -y build-essential
				;;
				
			4)
				#Install Nodejs
				echo "Installing Nodejs"
				curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
				apt install -y nodejs
				;;

			5)
				#Install git
				echo "Installing Git, please congiure git later..."
				apt install git -y
				;;

	    esac
	done
fi
