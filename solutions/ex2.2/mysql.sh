#!/bin/bash

set -x

if [ -z "$( ls -A '/var/lib/mysql' )" ]; then
  /usr/sbin/mysqld --initialize-insecure --user=mysql

  nohup /usr/sbin/mysqld --user=mysql &
  
  tfile=$(mktemp)
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY \"$MYSQL_ROOT_PASSWORD\";
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER \"$MYSQL_USER\"@'%' IDENTIFIED BY \"$MYSQL_PASSWORD\";
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to \"$MYSQL_USER\"@'%';
FLUSH PRIVILEGES;" >> $tfile

  sleep 30

  /usr/bin/mysql -u root < $tfile
  rm $tfile
else
  /usr/sbin/mysqld --user=mysql
fi

