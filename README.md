SFLinux-BaseImage
=================

Ce dépot va vous permettre de créer une image [Docker](http://docker.io) de base, contenant Linux, Apache, MySQL, git, drush et d'autres paquets utiles pour développer et faire tourner un site Drupal. Pour l'utiliser, vous devez avoir [installé Docker](http://www.docker.io/gettingstarted/).

Cette image est utilisé pour plusieurs projets Drupal comme [SFL Boilerplate](https://gitlab.savoirfairelinux.com/drupal/sfl-boilerplate) ou [My Dauphine](https://gitlab.savoirfairelinux.com/paris-dauphine/dauphine-espace-etudiant). Le but est de fournir une image de base que l'on pourra utiliser pour chacun de nos projets Drupal.

Si vous avez déjà travaillé sur un site Drupal avec Docker, il y a des chances que vous ayez déjà installé cette image. Vous pouvez le constater en éxecutant la commande :

    $ docker images
    REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    sflinux/baseimage       latest              a57eacb74c44        4 days ago          723.7 MB

Si vous voyez l'image sflinux/baseimage, vous pouvez installer l'image du projet sans problème. Sinon, poursuivez cette procédure

Installation de Docker
----------------------

Cette étape est inutile si vous avez déjà installé Docker.

La [procédure d'installation](https://docs.docker.com/installation) est décrite sur le site officiel.

Pensez aussi à mettre docker en mode sudo :

    # Add the docker group if it doesn't already exist.
    $ sudo groupadd docker

    # Add the connected user "${USER}" to the docker group.
    # Change the user name to match your preferred user.
    # You may have to logout and log back in again for
    # this to take effect.
    $ sudo gpasswd -a ${USER} docker

    # Restart the Docker daemon.
    # If you are in Ubuntu 14.04, use docker.io instead of docker
    $ sudo service docker restart

Puis à vous déconnecter/reconnecter pour finaliser l'isntallation et la configuration

Installation de l'image de base
-------------------------------

Clonez de dépot quelquepart sur votre poste de travail et descendez dedans :

    $ git clone https://gitlab.savoirfairelinux.com/drupal/docker-lampd.git
    $ cd docker-lampd

Ceci fait, lancez la création de l'image :

    $ docker build -t sflinux/baseimage .

Ça peut être une opération relativement longue. Une fois terminé, vous devez voir le message : "Successfully built {hash}"

Vous disposez maintenant de l'image de base que l'on utilisera pour tous les projets Drupal.

Vous pouvez vérfier qu'elle existe en faisant :


    $ docker images
    REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    sflinux/baseimage       latest              a57eacb74c44        4 days ago          723.7 MB

Plus d'infos à propos de ce projet
----------------------------------

Ce projet utilise lui même une image de base phusion/baseimage pour se construire correctement, avec l'ensemble des paquets nécessaires au développement d'un site Drupal.

Pour en savoir plus à propos de phusion/baseimage, et notamment pourquoi on a choisi cette image plutôt que ubuntu/14.04, jetez un coup d'oeil ici : [Phusion Baseimage](https://registry.hub.docker.com/u/phusion/baseimage/).

Lancer un conteneur à partir de cette image est inutile, c'est une image qui servira de base pour les images projet.


Contribution
------------

N'hésitez pas, toute amélioration est bonne à prendre. :)


Auteurs
-------

Créé et maintenu par [Ernesto Rodriguez Ortiz](ernesto.rodriguezortiz@savoirfairelinux.com).

Documentation par [Philippe MOUCHEL](philippe.mouchel@savoirfairelinux.com).

Licence
-------

GPL v2
