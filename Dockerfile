FROM ubuntu:14.04
MAINTAINER Sven Stam <sven@legalthings.io>

# Install base packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    LANG=C.UTF-8 add-apt-repository ppa:ondrej/php5-5.6 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mongo \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php5-intl \
        php-pear \
        php-apc && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN /usr/sbin/php5enmod mcrypt
RUN a2enmod rewrite

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD sample/ /app

EXPOSE 80
WORKDIR /app
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
