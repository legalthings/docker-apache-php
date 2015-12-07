legalthings-docker-php
================

Base docker image to run PHP applications on Apache


Building the base image
-----------------------

To create the base image `legalthings/apache-php`, execute the following command on the tutum-docker-php folder:

    docker build -t legalthings/apache-php .

Loading your custom PHP application
-----------------------------------

This image can be used as a base image for your PHP application. Create a new `Dockerfile` in your
PHP application folder with the following contents:

    FROM legalthings/apache-php

After that, build the new `Dockerfile`:

    docker build -t username/php-app .

Running it:

    docker run -d -p 80:80 username/php-app

Check your deployment:

    curl http://localhost/


Loading your custom PHP application with composer requirements
--------------------------------------------------------------

Create a Dockerfile like the following:

    FROM legalthings/apache-php
    RUN rm -fr /app
    ADD . /app
    RUN composer install
