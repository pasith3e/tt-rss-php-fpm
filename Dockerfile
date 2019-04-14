FROM php:7.2-fpm-alpine
RUN apk add --no-cache --virtual .build-deps \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    postgresql-dev \
    icu-dev \
    busybox-suid \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j5 mbstring json gd pdo pdo_pgsql pgsql xml opcache 
COPY crontab /home/www-data/crontab
RUN /usr/bin/crontab -u www-data /home/www-data/crontab 
CMD /usr/sbin/crond && docker-php-entrypoint php-fpm

