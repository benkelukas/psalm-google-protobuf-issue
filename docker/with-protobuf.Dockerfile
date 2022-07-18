FROM php:8.1-alpine3.16

# Install PHP Extensions Installer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Make installed scripts executable
RUN chmod +x /usr/local/bin/install-php-extensions

# Install ProtoBuf extension
RUN install-php-extensions protobuf \
    && docker-php-ext-enable protobuf

WORKDIR /app
