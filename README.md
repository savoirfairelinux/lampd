Bocker-BaseImage
================

This repo contains a recipe for making a [Docker](http://docker.io) baseimage using Linux, Apache, MySQL, git, drush, and more. 
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/).

This image is used in other projects like [Drupal sfl-boilerplate](https://gitlab.savoirfairelinux.com/drupal/sfl-boilerplate) and the purpouse is to provide to others Drupal projects a baseimage with all dependency installed to make tests and install Drupal.

## Install docker:

Log into your Ubuntu installation as a user with sudo privileges.

Verify that you have wget installed.
```
$ which wget
```
If wget isn't installed, install it after updating your manager:
```
$ sudo apt-get update $ sudo apt-get install wget
```
Get the latest Docker package.
```
$ wget -qO- https://get.docker.com/ | sh
```
The system prompts you for your sudo password. Then, it downloads and installs Docker and its dependencies.

Verify docker is installed correctly.
```
$ sudo docker version
```
This command should show you the version of docker installed in your system

Add your user to the docker group to be able to execute docker command wihtout sudo
```
$ adduser <user> docker
```
Remember logout and login to the last command take effect.

#### To install docker in other OS look [here](https://docs.docker.com/installation)

## Clone this repo somewhere, 
```
$ git clone https://gitlab.savoirfairelinux.com/drupal/docker-lampd.git
$ cd docker-lampd
```
and then build it:
```
$ docker build -t sflinux/baseimage .
```

this can take a while but should eventually return a command prompt. It's done when it says "Successfully built {hash}"

That's it!
Now you have your base image that can be used in all your Drupal projects instead of use ubuntu:lastes or ubuntu:14.04

You can verifid this runing

```
$ docker images
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

Created and maintained by [Ernesto Rodriguez Ortiz](ernesto.rodriguezortiz@savoirfairelinux.com>)

## License
GPL v2