FROM alpine:edge
ENV TZ 'Asia/Shanghai'

# Download applications
RUN apk upgrade --no-cache \
&& echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
&& apk --update add --no-cache wget shadowsocks-libev openssh bash tzdata nginx supervisor \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo '${TZ}' > /etc/timezone \
# Get plugin
&& cd /tmp \
&& plugin_version=$(wget -O - https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | grep tag_name | awk  -F '"' '{print $4}') \
&& wget https://github.com/shadowsocks/v2ray-plugin/releases/download/$plugin_version/v2ray-plugin-linux-amd64-$plugin_version.tar.gz \
&& tar -xzvf v2ray-plugin-linux-amd64-*.tar.gz \
&& mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin \
# Clean
&& apk del wget \
&& rm -rf /tmp/* /var/cache/apk/* \
# Config ssh
&& echo "root:Docker!" | chpasswd
# Load your config
ADD etc /etc
COPY entrypoint.sh /usr/local/bin/
# Azure need this
ENV WEBSITES_PORT 80
EXPOSE $WEBSITES_PORT 2222

ENTRYPOINT ["entrypoint.sh"]
