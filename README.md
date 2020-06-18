A Drupal-oriented LAMP stack base image for Docker
==================================================

Lampd is a Docker base image, based itself on modified Ubuntu base image *Phusion*.

Learn more at Docker Hub on [Phusion Base Image](https://hub.docker.com/r/phusion/baseimage/).

Lampd is available for pulling from the [Docker registry](https://hub.docker.com/r/savoirfairelinux/lampd/).

Contents
--------

On top of all [the components](https://github.com/phusion/baseimage-docker#whats-inside-the-image) provided by the Phusion base image, Lampd base image contains essential components for Drupal development:

* Ubuntu 16.04 LTS as base system
* Apache2
* MySQL
* PHP 7.2
* Git
* Composer
* Drush 8.x
* Behat 3.0 with [Drupal Extension](https://www.drupal.org/project/drupalextension)
* A [JUnit formatter](https://packagist.org/packages/jarnaiz/behat-junit-formatter) for Behat 3.0
* Asciidoctor

Use Lampd as base image
-----------------------

The image is called _savoirfairelinux/lampd_, and is available on the Docker registry.

```
# Docker Drupal
# VERSION       0.3
FROM    savoirfairelinux/lampd
```

Usage
-----

Start a container:
```
docker run YOUR_IMAGE
```

Find out the container ID that you just ran:
```
docker ps
```

Once you have the ID, look for its IP address with:
```
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <ID>
```

Now that you have the IP address, you can use SSH to login to the container, or to execute a command inside it:
```
# Login to the container
ssh -i /path-to/your_key root@<IP address>

# Running a command inside the container
ssh -i /path-to/your_key root@<IP address> echo hello world
```

Authors
-------

Created by [Ernesto Rodriguez Ortiz](ernesto.rodriguezortiz@savoirfairelinux.com) and Savoir-faire Linux Drupal Team.
Maintained by [Mohammed Raza] (mohammed.raza@savoirfairelinux.com)

Licence
-------

GPL v2
