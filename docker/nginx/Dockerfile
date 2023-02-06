################################
FROM nginx:1.17-alpine
################################
ENV TZ=Europe/Paris

ARG APP_ENV

RUN apk add --update tzdata openssl

RUN mkdir /etc/letsencrypt

COPY docker/nginx/$APP_ENV.conf /etc/nginx/conf.d/default.conf
COPY docker/nginx/0custom.conf /etc/nginx/conf.d/0custom.conf

RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./FR=cytrums.local" -addext "subjectAltName=DNS:cytrums.local" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

COPY public /var/www/public
RUN chown -R nginx:nginx /var/www/
