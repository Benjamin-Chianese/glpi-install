#!/bin/bash

echo -e "\033[32mMise a jour de debian apres l'installation :\E[0m"
echo -e "\033[34msudo apt update && sudo apt upgrade -y\E[0m"
	sudo apt-get update > /dev/null 2>&1
	sudo apt-get upgrade -y > /dev/null 2>&1

echo ""
echo -e "\033[32mInstallation de LAMP, le serveur WEB de la machine et PHP :\E[0m"
echo -e "\033[34msudo apt-get install apache2 php libapache2-mod-php php-imap php-ldap php-curl php-xmlrpc php-gd php-mysql php-cas php-intl -y\E[0m"
	sudo apt-get install apache2 php libapache2-mod-php php-imap php-ldap php-curl php-xmlrpc php-gd php-mysql php-cas php-intl -y > /dev/null 2>&1

echo ""
echo -e "\033[32mInstallation de MariaDB, le serveur de base de donnee :\E[0m"
echo -e "\033[34msudo apt-get install mariadb-server -y\E[0m"
	sudo apt-get install mariadb-server -y > /dev/null 2>&1

echo ""
echo -e "\033[32mCreation du mot de passe ROOT pour la MariaDB :\E[0m"
echo -e "\033[34msudo mysql_secure_installation\E[0m"
	sudo mysql_secure_installation

echo ""
echo -e "\033[32mInstallation des dependance PHP :\E[0m"
echo -e "\033[34msudo apt-get install apcupsd php-apcu -y\E[0m"
	sudo apt-get install apcupsd php-apcu -y > /dev/null 2>&1

echo ""
echo -e "\033[32mRedemarrage du service Apache2 et MariaDB :\E[0m"
echo -e "\033[34msudo /etc/init.d/apache2 restart\E[0m"
	sudo /etc/init.d/apache2 restart 
echo -e "\033[34msudo /etc/init.d/mariadb restart\E[0m"
	sudo /etc/init.d/mariadb restart

echo ""
echo -n -e "\033[32mTaper le mot de passe ROOT MariaDB:\E[0m"
    read -s rootpasswd

echo ""
echo -e "\033[32mCreation de la base de donne GLPI et de l'utilisateur dedie :\E[0m"
echo -e "\033[34mCREATE DATABASE glpidb;\E[0m"
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE glpidb;"
echo -e "\033[34mGRANT ALL PRIVILEGES ON glpidb.* to glpiuser@localhost IDENTIFIED BY 'glpiuser';\E[0m"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON glpidb.* to glpiuser@localhost IDENTIFIED BY 'glpiuser';"
echo -e "\033[34mquit\E[0m"

echo ""
echo -e "\033[32mAjout d'une nouvelle source a debian pour installer PhpMyAdmin :\E[0m"
echo -e "\033[34msudo echo 'deb http://deb.debian.org/debian bullseye-backports main'\E[0m"
	sudo echo 'deb http://deb.debian.org/debian bullseye-backports main' >> /etc/apt/sources.list

echo ""
echo -e "\033[32mMise a jour des paquets et installation des dependances et de PhpMyAdmin :\E[0m"
echo -e "\033[34msudo apt update\E[0m"
	sudo apt update > /dev/null 2>&1
echo -e "\033[34msudo apt-get upgrade php-tcpdf php-twig -y\E[0m"
	sudo apt-get upgrade php-tcpdf php-twig -y > /dev/null 2>&1
echo -e "\033[34msudo apt-get install -t bullseye-backports php-twig\E[0m"
	sudo apt-get install -t bullseye-backports php-twig > /dev/null 2>&1
echo -e "\033[34msudo apt-get install phpmyadmin -y\E[0m"
	sudo apt-get install phpmyadmin -y

echo ""
echo -e "\033[32mTelechargement de GLPI :\E[0m"
echo -e "\033[34mcd /tmp\E[0m"
	cd /tmp
echo -e "\033[34mwget https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz\E[0m"
	wget https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz

echo ""
echo -e "\033[32mDecompression de l'archive de GLPI dans le dossier WEB:\E[0m"
echo -e "\033[34msudo tar -xvzf glpi-10.0.3.tgz -C /var/www/html\E[0m"
	sudo tar -xvzf glpi-10.0.3.tgz -C /var/www/html > /dev/null 2>&1

echo ""
echo -e "\033[32mAjout des droits de Apache2 sur le dossier GLPI\E[0m"
echo -e "\033[34msudo chown -R www-data /var/www/html/glpi/\E[0m"
	sudo chown -R www-data /var/www/html/glpi/
