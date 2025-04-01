# Занимаемся перекладыванием питона :)
# Да, не из бинарника, но меньше в 4 раза чем оригинальный образ

FROM python:3.13-slim as builder

RUN mkdir -p /min/lib /min/lib64 /min/usr/local/lib /min/usr/local/bin

RUN cp -r /usr/local/lib/python3.13 /min/usr/local/lib/python3.13

RUN cp /usr/local/bin/python3.13 /min/python3

RUN cp /usr/local/lib/libpython3.13.so.1.0 /min/lib/

RUN cp /lib/x86_64-linux-gnu/libc.so.6 /min/lib/
RUN cp /lib/x86_64-linux-gnu/libm.so.6 /min/lib/

RUN cp /lib64/ld-linux-x86-64.so.2 /min/lib64/

FROM scratch
COPY --from=builder /min/ /

ENTRYPOINT ["/python3", "-V"]