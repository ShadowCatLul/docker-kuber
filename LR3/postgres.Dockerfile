# Stage 1: Базовый образ PostgreSQL
FROM postgres:latest AS builder

# Stage 2: Минимальный образ
FROM debian:bookworm-slim

# Устанавливаем минимальные зависимости и настраиваем среду одной командой
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 libc6 libssl3 libldap-2.5-0 locales tzdata \
    libxml2 libicu72 liblz4-1 libzstd1 libuuid1 \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && groupadd -r postgres && useradd -r -g postgres postgres \
    && mkdir -p /var/lib/postgresql/data /var/run/postgresql /docker-entrypoint-initdb.d \
    && chmod 777 /var/run/postgresql \
    && chown -R postgres:postgres /var/lib/postgresql /var/run/postgresql /docker-entrypoint-initdb.d

# Копируем только необходимые компоненты PostgreSQL из базового образа
COPY --from=builder /usr/lib/postgresql/ /usr/lib/postgresql/
COPY --from=builder /usr/share/postgresql/ /usr/share/postgresql/
COPY --from=builder /usr/bin/psql /usr/bin/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /etc/postgresql/ /etc/postgresql/

# Копируем бинарные файлы PostgreSQL из директории
COPY --from=builder /usr/lib/postgresql/*/bin/postgres /usr/bin/
COPY --from=builder /usr/lib/postgresql/*/bin/initdb /usr/bin/

# Настройка переменных окружения
ENV LANG=en_US.utf8 \
    PGDATA=/var/lib/postgresql/data \
    PATH=$PATH:/usr/lib/postgresql/15/bin:/usr/bin \
    POSTGRES_PASSWORD=postgresql \
    POSTGRES_USER=postgresql

# Переключаемся на пользователя postgres
USER postgres

# Открываем порт и указываем том
EXPOSE 5432
VOLUME ["/var/lib/postgresql/data"]

# Запускаем PostgreSQL
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]