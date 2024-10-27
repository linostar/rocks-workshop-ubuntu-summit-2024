#!/bin/bash

sleep 5
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'mypass'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
