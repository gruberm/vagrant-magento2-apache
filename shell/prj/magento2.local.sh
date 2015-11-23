#!/usr/bin/env bash
DB=magento2
USER=magento
PW=magento2

# db for project
# --------------------
mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS ${DB} CHARACTER SET utf8 COLLATE utf8_general_ci"
mysql -uroot -proot -e "CREATE USER '${USER}'@'localhost' IDENTIFIED BY '${PW}'"
mysql -uroot -proot -e "GRANT USAGE ON *.* TO '${USER}'@'localhost' IDENTIFIED BY '${PW}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON ${DB}.* TO '${USER}'@'localhost' WITH GRANT OPTION"
mysql -uroot -proot -e "FLUSH PRIVILEGES"