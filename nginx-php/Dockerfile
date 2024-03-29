FROM alpine:edge
MAINTAINER Winston H.
# 设置中国时区
ENV TZ='Asia/Shanghai'
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo '${TZ}' > /etc/timezone \
    && rm -rf /var/cache/apk/*
# 添加nginx与php全家桶
RUN apk --update --no-cache add nginx php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-memcached php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mbstring php7-xmlwriter php7-simplexml \
    && rm -rf /var/cache/apk/*
RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf /etc/nginx/
ENV PHP_FPM_USER="www"
ENV PHP_FPM_GROUP="www"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_MAX_UPLOAD="50M"
ENV PHP_MAX_FILE_UPLOAD="200"
ENV PHP_MAX_POST="100M"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO=0
RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.conf && \
    sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf && \
    sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.conf #uncommenting line
RUN sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini && \
    sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini && \
    sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini && \
    sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini && \
    sed -i "s|;*date.timezone =.*|date.timezone = ${TZ}|i" /etc/php7/php.ini #config timezone
# /etc/php7/php-fpm.conf
# /etc/php7/php.ini
ADD etc /etc
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
&&apk --update --no-cache add unzip git wget curl supervisor sudo openssl openssh bash \
&& addgroup alpine \
&& adduser -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& echo "root:Docker!" | chpasswd \
&& rm -rf /tmp/* /var/cache/apk/* /etc/nginx/conf.d/default.conf
# Add websites here
COPY *.zip /home/site/wwwroot/
RUN cd /home/site/wwwroot \
&& unzip /home/site/wwwroot/DirectoryLister.zip \
&& mv /home/site/wwwroot/DirectoryLister-master/* /home/site/wwwroot \
&& rm -f /home/site/wwwroot/DirectoryLister.zip/ \
&& mkdir /home/site/wwwroot/admin \
&& mv kodexplorer*.zip /home/site/wwwroot/admin \
&& cd /home/site/wwwroot/admin \
&& unzip kodexplorer*.zip \
&& mv KodExplorer*/* . \
&& rm -r  KodExplorer* \
&& chmod 777 -Rf /home/site/wwwroot/admin \
&& chown -R nobody:nobody /home/site/wwwroot \
&& rm kodexplorer*.zip
# End websites adding
COPY entrypoint.sh /usr/sbin/

ENV WEBSITES_PORT 80
EXPOSE $WEBSITES_PORT 2222
ENTRYPOINT ["entrypoint.sh"]
