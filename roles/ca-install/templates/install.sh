#!/bin/bash

DATABASE_ADMIN_USERNAME="${1}"
DATABASE_ADMIN_PASSWORD="${2}"
UIM_ADMINISTRATOR_USER_NAME="${3}"
UIM_ADMINISTRATOR_USER_PASSWORD="${4}"
yum-complete-transaction -y
yum-complete-transaction -y
yum-complete-transaction -y

cd /uim

PW='QWzxPOmn0987!@#$'
mount -t cifs -o domain='t3n',username='svc_ecosys',password=`echo $PW` //172.17.1.23/Software/Ecosystem_Images /mnt

cp /mnt/CA/UIM/uim.zip .
umount /mnt
unset PW

unzip -o uim.zip

perl -p -i -e "s/DB_ADMIN_USER=root/DB_ADMIN_USER=${1}/ig" NMS_installer.properties
perl -p -i -e "s/DB_ADMIN_PASSWORD=nimsoft/DB_ADMIN_PASSWORD=${2}/ig" NMS_installer.properties
perl -p -i -e "s/NIM_USER=administrator/NIM_USER=${3}/ig" NMS_installer.properties
perl -p -i -e "s/NMS_PASSWORD=nimsoft/NMS_PASSWORD=${4}/ig" NMS_installer.properties
perl -p -i -e "s/NIMBUS_USERNAME=administrator/NIMBUS_USERNAME_USER=${3}/ig" UMP_installer.properties
perl -p -i -e "s/NIMBUS_PASSWORD=nimsoft/NIMBUS_PASSWORD=${4}/ig" UMP_installer.properties
perl -p -i -e "s/nimsoft/${2}/ig" mysql-init.sql

./provision.sh $2

exit 0

