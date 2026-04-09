FROM php:8.4-cli

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl unzip libzip-dev libonig-dev libpng-dev \
    nodejs npm \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project
COPY . .

# Create sqlite file
RUN mkdir -p database \
    && touch database/database.sqlite \
    && chmod -R 777 database

# Install dependencies
RUN composer install

# Setup Laravel
RUN cp .env.example .env || true
RUN php artisan key:generate

#  IMPORTANT: clear cache (fix your error)
RUN php artisan config:clear
RUN php artisan cache:clear
RUN php artisan view:clear

# Fix permissions
RUN chmod -R 775 storage bootstrap/cache

# Install frontend
RUN npm install && npm run build

# Expose port
EXPOSE 8000

# Run Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
