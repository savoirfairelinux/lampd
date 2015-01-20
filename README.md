Bocker-BaseImage
================

This repo contains a recipe for making a [Docker](http://docker.io) baseimage using Linux, Apache, MySQL, git, drush, and more. 
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/).

This will try to go in line with [Drupal automated-testing](https://drupal.org/automated-testing).

This image is used in other projects like [Drupal sfl-boilerplate](https://gitlab.savoirfairelinux.com/drupal/sfl-boilerplate) and the purpouse is to provide to others Drupal projects a baseimage with all dependency installed to make tests and install Drupal.

## Install docker:
First, check that your APT system can deal with https URLs: the file /usr/lib/apt/methods/https should exist. If it doesn't, you need to install the package apt-transport-https.
```
[ -e /usr/lib/apt/methods/https ] || {
  apt-get update
  apt-get install apt-transport-https
}
```

Then, add the Docker repository key to your local keychain.
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
```
Add the Docker repository to your apt sources list, update and install the lxc-docker package.
```
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker
```

Add your user to the docker group to be able to execute docker command wihtout sudo

```
adduser <user> docker
```

## Clone this repo somewhere, 
```
git clone https://gitlab.savoirfairelinux.com/erortiz/docker-lampd.git
cd docker-lampd
```
and then build it:
```
sudo docker build -t sflinux/baseimage .
```

this can take a while but should eventually return a command prompt. It's done when it says "Successfully built {hash}"

That's it!
Now you have your base image that can be used in all your Drupal projects instead of use ubuntu:lastes or ubuntu:14.04

You can verifid this runing

```
# sudo docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
sflinux/baseimage       latest              a57eacb74c44        4 days ago          723.7 MB
```

### More information about this project

This project use phusion/baseimage like base image to build and image with all the software neede to install Drupal projects and make tests

To read about why use phusion/baseimage and not ubuntu:14.04 look at [Phusion Baseimage](https://registry.hub.docker.com/u/phusion/baseimage/).

You generally not will need to run this image, it will be used generally to build other images


## Contributing
Feel free to fork and contribute to this code. :)


## Authors

Created and maintained by [Ernesto Rodriguez Ortiz][author] (ernesto.rodriguezortiz@savoirfairelinux.com>)

## License
GPL v2

