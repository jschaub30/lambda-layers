#!/bin/bash
# Install mysqldump in Amazon Linux
# Run script under root/sudo
set -x

wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
dnf install mysql80-community-release-el9-1.noarch.rpm -y
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
dnf install mysql-community-server -y
