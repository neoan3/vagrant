#! /usr/bin/env bash

    # Install apache server , mysql
    echo "** 1/6 Install Apache & MySQL ** "
    apt-get -qq install software-properties-common -y
    add-apt-repository ppa:ondrej/php -y
    apt-get update
    apt-get -qq install -y apache2
    apt-get -qq install -y mysql-server

    # Create default database
    echo "** 2/6 Create & Setup default database neoan3 ** "
    mysql -e "create database neoan3"
    mysql -e "create user 'neoan3'@'localhost'"
    mysql -e "grant all privileges on neoan3.* to 'neoan3'@'localhost'"
    mysql -e "flush privileges"

    # Install PHP8 & modules
    echo "** 3/6 Install PHP8 & modules ** "
    apt-get -qq install -y php8.0 libapache2-mod-php8.0 php8.0-{mysql,zip,xml,curl,mbstring,xdebug} curl git
    echo "
      zend_extension=xdebug.so
      xdebug.mode=debug,coverage
      xdebug.client_host=192.168.33.10
      xdebug.discover_client_host=true
    " > /etc/php/8.0/mods-available/xdebug.ini
    apt-get upgrade

    # Install & setup Composer
    echo "** 4/6 Install & Setup composer** "
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

    # Install & setup neoan3 cli
    echo "** 5/6 Install & Setup neoan3 cli** "
    sudo touch /var/www/.safe-space
    sudo -u vagrant -i composer global require neoan3/neoan3
    mkdir /credentials
    echo '{\"testing_db\":{\"host\":\"localhost\",\"user\":\"neoan3\",\"name\":\"neoan3\",\"assumes_uuid\":true}}' > /credentials/credentials.json
    chown vagrant:vagrant -R /credentials
    echo "PATH=$PATH:/home/vagrant/.config/composer/vendor/bin" >> /home/vagrant/.profile
    echo "cd /var/www/html" >> /home/vagrant/.profile
    NEOAN_APP=/var/www/html/version.json
    if [ ! -f \"$NEOAN_APP\" ]; then
        cd /var/www/html
        rm /var/www/html/index.html
        sudo -u vagrant -i neoan3 new app
        echo \"Installing neoan3\ \"
    fi

    # Configure Apache
    echo "** 6/6 configure Apache** "
    echo "<VirtualHost *:80>
        DocumentRoot /var/www/html
        AllowEncodedSlashes On
        <Directory /var/www/html>
            Options +Indexes +FollowSymLinks
            DirectoryIndex index.php index.html
            Order allow,deny
            Allow from all
            AllowOverride All
            <IfModule php_module\>
                    AddHandler application/x-httpd-php .php
            </IfModule>
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>" > /etc/apache2/sites-available/000-default.conf
    a2enmod rewrite
    service apache2 restart
    echo "** neoan3 box running... visit http://192.168.33.10 in your browser for to view the application ** "
    echo "** .. vagrant ssh .. ** "
    echo "** ... synced working directory .. ** "
