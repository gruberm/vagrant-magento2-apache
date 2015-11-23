#!/usr/bin/env bash

echo "--------------"
echo "| APT UPDATE |"
echo "--------------"
apt-get update


echo "--------------------------"
echo "| INSTALL APACHE AND PHP |"
echo "--------------------------"
if [ ! -d /etc/apache2 ]
then
    apt-get install -y apache2
    apt-get install -y php5
    apt-get install -y libapache2-mod-php5
    apt-get install -y php5-mysqlnd php5-curl php5-xdebug php5-gd php5-intl php-pear php5-imap php5-mcrypt php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php-soap git bindfs htop

    sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=vagrant/g" /etc/apache2/envvars
    sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=vagrant/g" /etc/apache2/envvars
    sed -i "/max_execution_time = 30/c max_execution_time = 300" /etc/php5/apache2/php.ini
    sed -i "/upload_max_filesize = 2M/c upload_max_filesize = 100M" /etc/php5/apache2/php.ini
    sed -i "/post_max_size = 8M/c post_max_size = 100M" /etc/php5/apache2/php.ini

    a2enmod rewrite
    a2enmod vhost_alias
    php5enmod mcrypt
    php5enmod imap
fi

if [ ! -d /home/vagrant/servers ]
then
    mkdir -p /home/vagrant/servers
fi

if [ ! -f /etc/apache2/sites-available/vagrant.conf ]
then
    cp /vagrant/config/etc/apache2/sites-available/vhost.conf /etc/apache2/sites-available/vagrant.conf
    a2ensite vagrant
fi


echo "-----------"
echo "| PERCONA |"
echo "-----------"
if [ -z `which mysql` ];
then
    export DEBIAN_FRONTEND=noninteractive
    echo "deb http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list
    echo "deb-src http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
    cp /vagrant/config/etc/apt/preferences.d/00percona.pref /etc/apt/preferences.d/00percona.pref
    apt-get update
    apt-get -q -y install percona-server-server percona-server-client
    mysqladmin -u root password root
    rm /etc/mysql/my.cnf
    cp /vagrant/config/etc/mysql/my.cnf /etc/mysql/my.cnf
fi


echo "---------------"
echo "| MAILCATCHER |"
echo "---------------"
if [ ! -f /etc/php5/mods-available/mailcatcher.ini ]
then
    apt-get install -y build-essential
    apt-get install -y libsqlite3-dev ruby1.9.1-dev
    gem install mailcatcher
    cp /vagrant/config/etc/php5/mods-available/mailcatcher.ini /etc/php5/mods-available/mailcatcher.ini
    php5enmod mailcatcher
    cp /vagrant/config/etc/init.d/mailcatcher.conf /etc/init/mailcatcher.conf
fi


echo "------------"
echo "| COMPOSER |"
echo "------------"
if [ -z `which composer` ];
then
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/bin/composer
fi


echo "----------"
echo "| XDEBUG |"
echo "----------"
rm /etc/php5/mods-available/xdebug.ini
cp /vagrant/config/etc/php5/mods-available/xdebug.ini /etc/php5/mods-available/xdebug.ini
php5dismod xdebug


echo "---------"
echo "| OAUTH |"
echo "---------"
if [ ! -f /etc/php5/mods-available/oauth.ini ]
then
    apt-get install -y php5-dev libpcre3-dev
    pecl install oauth
    cp /vagrant/config/etc/php5/mods-available/oauth.ini /etc/php5/mods-available/oauth.ini
    php5enmod oauth
fi