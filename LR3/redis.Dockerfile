# Используем официальный образ Redis
FROM redis:latest

# Указываем метаданные
LABEL maintainer="admin@example.com"
LABEL description="Redis server for application"

# Открываем порт
EXPOSE 6379

# Запускаем Redis с конфигурацией по умолчанию
CMD ["redis-server"]