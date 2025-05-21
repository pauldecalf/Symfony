# Dockerfile

FROM php:8.2-fpm

# Install des dépendances système
RUN apt-get update && apt-get install -y \
    git unzip zip curl libpq-dev libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Symfony CLI (facultatif mais utile)
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Configuration personnalisée
COPY .docker/symfony.ini /usr/local/etc/php/conf.d/

# Dossier de travail
WORKDIR /var/www/html

# Droits
RUN chown -R www-data:www-data /var/www

CMD ["php-fpm"]
