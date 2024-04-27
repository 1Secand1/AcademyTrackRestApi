FROM php:7.4-apache

RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN a2enmod rewrite
RUN a2enmod headers

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
