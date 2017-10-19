FROM ubuntu:16.04
MAINTAINER Miguel Ángel Vicedo <miguel.angel.vicedo@accenture.com>

# Environments vars
ENV TERM=xterm

RUN apt-get update
RUN apt-get -y upgrade

# Packages installation
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install apache2 \
      php \
      php-cli \
      php-gd \
      php-json \
      php-mbstring \
      php-xml \
      php-xsl \
      php-zip \
      php-soap \
      php-pear \
      php-mcrypt \
      libapache2-mod-php \
      curl \
      php-curl \
      apt-transport-https \
      nano \
      lynx-cur

RUN a2enmod rewrite
RUN phpenmod mcrypt


# Init
ADD init.sh /init.sh
RUN chmod 755 /*.sh

# Add phpinfo script for INFO purposes
RUN echo "<?php phpinfo();" >> /var/www/html/info.php
COPY dist/ /var/www/html

RUN service apache2 restart

RUN chown -R www-data:www-data /var/www

#WORKDIR /var/www/


# Volume
#VOLUME /var/www

COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80:80
CMD ["/usr/local/bin/run"]# Ports: apache2
