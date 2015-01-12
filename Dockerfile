# docker Drupal
#
# VERSION       0.2
# DOCKER-VERSION        0.4
FROM    ubuntu:trusty
MAINTAINER Ernesto Rodriguez Ortiz <ernesto.rodriguezortiz@savoirfairelinux.com>

# Update software source
RUN apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl  

# Install Apache, MySQL, PHP, and others..
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install curl wget git mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql php-apc php5-gd php5-curl php5-memcache memcached mc php-pear postfix php5-imagick php5-dev build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean

# Install drush, phpmd, phpcpd, site_audit, uploadprogress
RUN pear channel-discover pear.drush.org && pear install drush/drush 
RUN pear channel-discover pear.phpmd.org && pear channel-discover 'pear.pdepend.org' && pear install --alldeps 'phpmd/PHP_PMD'
RUN wget http://pear.phpunit.de/get/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd
RUN drush dl site_audit -y
RUN pecl install -Z uploadprogress
RUN echo "extension=uploadprogress.so" >> /etc/php5/apache2/conf.d/uploadprogress.ini
RUN ln -s /etc/php5/mods-available/uploadprogress.ini /etc/php5/apache2/conf.d/20-uploadprogress.ini

# Make mysql listen on the outside
RUN sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf

COPY start-servers /usr/local/bin/
WORKDIR /var/www/html
EXPOSE 80
CMD ["start-servers"]