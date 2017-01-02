FROM ubuntu:14.04
MAINTAINER Sven Stam <sven@legalthings.io>

# Install base packages
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN LANG=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
	unzip \
	pkg-config \
        apache2 \
	libapache2-mod-php5.6 \
        php5.6-mongo \
        php5.6-mcrypt \
        php5.6-gd \
        php5.6-curl \
        php5.6-intl \
        php5.6-xml \
        php5.6-mbstring \
 	php5.6-dev && \
        rm -rf /var/lib/apt/lists/* && \
        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN /usr/sbin/phpenmod mcrypt
RUN a2enmod rewrite

RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/5.6/mods-available/mongo.ini

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD sample/ /app

RUN php -v

EXPOSE 80
WORKDIR /app
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
