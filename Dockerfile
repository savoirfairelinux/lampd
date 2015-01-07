# docker Drupal
#
# VERSION       0.2
# DOCKER-VERSION        0.4
FROM    ubuntu:14.04
MAINTAINER Ricardo Amaro <mail@ricardoamaro.com>

#RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update
#RUN apt-get -y upgrade

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl  

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install curl wget git mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql php-apc php5-gd php5-curl php5-memcache memcached mc php-pear
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean
RUN pear channel-discover pear.drush.org && pear install drush/drush

# Make mysql listen on the outside
RUN sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf

RUN easy_install supervisor
COPY ./deploy/jenkins-post-build.sh /jenkins-post-build.sh
COPY ./deploy/foreground.sh /etc/apache2/foreground.sh
COPY ./deploy/supervisord.conf /etc/supervisord.conf

#Drupal make
COPY ./sfl/sflinux.make /var/www/drupal/sflinux.make
COPY ./sfl/drupal-org-core.make /var/www/drupal/drupal-org-core.make

# Retrieve drupal
RUN mkdir /var/www/drupal; cd /var/www/drupal ; drush make --prepare-install sflinux.make src --yes 
RUN drush status
RUN chmod a+w /var/www/drupal/src/sites/default ; chown -R www-data:www-data /var/www/drupal
RUN rm /var/www/drupal/src/sites/default/settings.php

#Add profile
COPY ./sfl/sflinux /var/www/drupal/src/profiles/sflinux 

#Copy vhost configuration and enable modules
COPY ./deploy/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite vhost_alias
RUN service apache2 restart

RUN chmod 755 /jenkins-post-build.sh /etc/apache2/foreground.sh
EXPOSE 80

CMD ["/bin/bash", "/jenkins-post-build.sh"]
