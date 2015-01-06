#!/bin/bash

echo "================= START INSTALL-MYSQL.SH $(date +"%r") ================="
echo " "
echo "BEGIN Set VM timezone ..."

# set vm timezone
echo $4 | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# a little housekeeping
echo "... Doing a little housekeeping ..."
sudo apt-get -y autoremove > /dev/null
sudo apt-get -y update --fix-missing > /dev/null

echo "... END Set VM timezone."
echo " "
echo "BEGIN Database setup ..."

if [ ! -d "/etc/mysql" ]; then
	sudo apt-get -y update > /dev/null

	echo "... Setting MySQL root user password ..."
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"

	echo "... Installing MySQL Server ..."
	# install mysql (-qq implies -y --force-yes)
	sudo apt-get install -qq mysql-server > /dev/null

	# make mysql available to connect to from outside world without ssh tunnel
	# copy file with above changes and the lower_case_table_names = 1 flag set to
	# ignore case sensitivity in the database
	sudo cp /vagrant/configs/my.cnf /etc/mysql/my.cnf

	sudo service mysql restart > /dev/null
fi

if [ ! -f /var/log/db_setup ]; then
	echo "... Setting up database and granting privileges ..."

	# add grant privileges to mysql root user (from all hosts)
	echo "CREATE DATABASE IF NOT EXISTS $3;" | mysql -uroot -p$1
	echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$1' WITH GRANT OPTION;" | mysql -uroot -p$1
	echo "FLUSH PRIVILEGES;" | mysql -uroot -p$1

	touch /var/log/db_setup
fi

if [ -f /vagrant/$2 ]; then
	echo "... SQL file found, importing data (this may take a few minutes) ..."
	# if a sql file is passed in (and exists in the data directory), import it
	echo "SOURCE /vagrant/$2;" | mysql -uroot -p$1 -f -D $3
fi

# create databases used for railo client and session storage
echo "... Creating databases for Railo's session and client storage ..."
echo "CREATE DATABASE IF NOT EXISTS railo_client;" | mysql -uroot -p$1
echo "CREATE DATABASE IF NOT EXISTS railo_session;" | mysql -uroot -p$1

echo "... END Database setup."
echo " "
echo "================= END INSTALL-MYSQL.SH $(date +"%r") ================="
