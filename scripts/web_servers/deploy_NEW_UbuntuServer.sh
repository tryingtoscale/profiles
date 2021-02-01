#!/bin/bash

#Check if Root
if [ "$UID" -ne "0" ]; then
  echo "Please sudo first....!"
  exit
else
  apt-get update
  apt install -y software-properties-common
  add-apt-repository ppa:ondrej/php
  apt-get update
  apt-get -y install dpkg-dev
  apt-get -y install build-essential
  apt-get -y install curl
  apt-get -y install screen
  apt-get -y install wget
  apt-get -y install apache2
  apt-get -y install apache2-utils
  a2enmod rewrite
  apt-get -y install mysql-server
  mysql_secure_installation
  apt-get -y install php7.4 php7.4-cli php7.4-dev php7.4-common
  apt-get -y install php7.4-mbstring php7.4-mysql php7.4-gd php7.4-json
  apt-get -y install php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-sqlite3
  phpenmod mbstring
  apt-get -y install libapache2-mod-php7.4
  #REDIS Cache Server
  apt-get -y install redis-server php-redis
  echo "" >> /etc/redis/redis.conf
  echo "maxmemory 128mb" >> /etc/redis/redis.conf
  echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf
  systemctl restart redis-server.service
  systemctl enable redis-server.service
  apt-get -y install phpmyadmin
  apt-get -y install nano
  apt-get -y install git
  #Remove Remove suid bits
  chmod -s /bin/fusermount
  chmod -s /bin/mount
  chmod -s /bin/su
  chmod -s /bin/umount
  chmod -s /usr/bin/bsd-write
  chmod -s /usr/bin/chage
  chmod -s /usr/bin/chfn
  chmod -s /usr/bin/chsh
  chmod -s /usr/bin/mlocate
  chmod -s /usr/bin/mtr
  chmod -s /usr/bin/newgrp
  chmod -s /usr/bin/traceroute6.iputils
  chmod -s /usr/bin/wall
  chmod 700 /root
  chmod 600 /etc/crontab
  chmod 700 /var/crash
  chown -R root:root /var/crash
  chmod 740 /etc/rc.d/init.d/iptables
  chmod 740 /sbin/iptables
  chmod 740 /usr/share/logwatch/scripts/services/iptables
  chmod -R 700 /etc/skel
  chmod 640 /etc/syslog.conf
  chmod 640 /etc/security/access.conf
  chmod 600 /etc/sysctl.conf
  #Disable un-needed services
  #/sbin/chkconfig bluetooth off
  /sbin/chkconfig irda off
  /sbin/chkconfig lm_sensors off
  /sbin/chkconfig portmap off
  /sbin/chkconfig rawdevices off
  /sbin/chkconfig rpcgssd off
  /sbin/chkconfig rpcidmapd off
  /sbin/chkconfig rpcsvcgssd off
  /sbin/chkconfig sendmail off
  /sbin/chkconfig xinetd off
  /sbin/chkconfig kudzu off
  #Disable un-needed users
  /usr/sbin/userdel shutdown
  /usr/sbin/userdel halt
  /usr/sbin/userdel games
  /usr/sbin/userdel operator
  /usr/sbin/userdel ftp
  /usr/sbin/userdel news
  /usr/sbin/userdel gopher
  #install npm
  cd /usr/local/bin && {
  apt-get -y install npm
  apt-get -y install nodejs-legacy
  npm install -g npm
  npm install -g n
  n stable
  npm install --global gulp-cli
} || echo "Unable to install npm!!"
  #PHP Composer
  cd /tmp && {
  wget -O composer-setup.php https://getcomposer.org/installer
  /usr/bin/php composer-setup.php --filename=composer --install-dir=/usr/local/bin
  rm composer-setup.php
} || echo "Unable to install PHP Composer!!"
fi
