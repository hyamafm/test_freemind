FROM php:7.4
RUN mkdir /root/composer
WORKDIR /root/composer
RUN \
  curl -k -o /usr/local/bin/composer -sS https://getcomposer.org/composer-2.phar   && chmod 755 /usr/local/bin/composer \
  && apt-get update \
  && apt-get install -y \
    git \
    libzip-dev \
    rsync \
    unzip \
    zlib1g-dev \
  && docker-php-ext-install \
    zip \
  && composer config --global process-timeout 0 \
  && composer require composer deployer/deployer:6.8.0 \
  && composer require symfony/finder \
  && composer require deployer/recipes --dev \
  && (for file in /root/composer/vendor/bin/*; do ln -s $file /usr/local/bin/ 2> /dev/null; done; exit 0)
WORKDIR /data
