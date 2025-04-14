# Используем официальный образ PgAdmin
FROM dpage/pgadmin4:latest

# Указываем метаданные
LABEL maintainer="admin@example.com"
LABEL description="PgAdmin for PostgreSQL management"

# Открываем порт
EXPOSE 80

# Запускаем PgAdmin (используем команду по умолчанию из официального образа)