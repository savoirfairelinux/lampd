# docker Drupal
#
# VERSION       0.2
# DOCKER-VERSION        0.4
FROM    phusion/baseimage
MAINTAINER Ernesto Rodriguez Ortiz <ernesto.rodriguezortiz@savoirfairelinux.com>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update software source
RUN apt-get update

# Install Apache, MySQL, PHP, and others..
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim curl wget git mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql php-apc php5-gd php5-curl php5-memcache memcached mc php-pear postfix php5-imagick php5-dev build-essential

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

# Adding additional memcached daemon
RUN mkdir /etc/service/memcached
ADD service/memcached.sh /etc/service/memcached/run

# Adding additional mysqld daemon
RUN mkdir /etc/service/apache2
ADD service/apache2.sh /etc/service/apache2/run

# Adding additional apache2 daemon
RUN mkdir /etc/service/mysqld
ADD service/mysqld.sh /etc/service/mysqld/run

# Expose port 80 for apache connection on the aoutside
EXPOSE 80

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
