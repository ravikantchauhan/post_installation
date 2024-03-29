#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating "
	apt-get update
	sudo apt-get install dialog
#######

cmd=(dialog --separate-output --checklist "PHP $(php -v | grep cli | awk '{print $2'}) already install:Are youn want uninstall? :" 22 76 16)
	options=(1 "yes uninstall " off    # any option can be set to default to "on"
	         2 "No- keep PHP $(php -v | grep cli | awk '{print $2'}) " off
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
				#sudo apt install -y python-software-properties
				sudo add-apt-repository -y ppa:ondrej/php
				sudo apt-get update
				#Install php
				echo "Installing php$php_versin"
				sudo apt install -y php$php_versin
				sudo apt-get install -y $php_versin-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common,dom}
				service apache2 restart
				##########
	            #######Mysql server
    			echo "Installing Mysql Server"
				var4="$(mysql -V | awk '{print $3'})"
				if [[ $var4 > 0 ]]; then
   				echo " mysql server $var4 is already install" 
   				exit 1
				else
				#Update and Upgrade
				echo "mysqlnot found"
				# apt-get update && sudo apt-get upgrade -y
    			#wget  https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb 
				#sudo dpkg -i mysql-apt-config_0.8.16-1_all.deb 
				sudo apt update
				sudo apt install mysql-server -y
				#sudo apt install mysql-workbench-community -y
				fi

        			echo "Installing Phpmyadmin"
        		if [[ -e /etc/phpmyadmin/apache.conf ]]; then
				echo "phpmyadmin is alreday install"
				exit 1
				else
				apt install phpmyadmin -y
				echo "Cofiguring apache to run Phpmyadmin"
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
    				sudo a2enmod headers
				echo "Restarting Apache Server"
				service apache2 restart
				cd /tmp/
				sudo tar -cvzf phpmyadmin-old.tar.gz /usr/share/phpmyadmin/
				cd  /usr/share/phpmyadmin/
				sudo rm -rf *
				 sudo rm -rf .*
				wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-english.tar.gz
				tar -xvf phpMyAdmin-5.2.1-english.tar.gz
				cd phpMyAdmin-5.2.1-english
				sudo mv *  /usr/share/phpmyadmin/
				sudo mv .*  /usr/share/phpmyadmin/
    				sudo update-alternatives --set php /usr/bin/php$php_versin
				sudo update-alternatives --set phar /usr/bin/phar$php_versin
				sudo update-alternatives --set phar.phar /usr/bin/phar.phar$php_versin
				systemctl restart apache2
				fi
				service apache2 restart
				;;	
    	    esac
	done
fi
###########
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES;
EOF
##########

