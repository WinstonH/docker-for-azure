FROM alpine:edge
MAINTAINER Winston H.
# 设置中国时区
ENV TZ 'Asia/Shanghai'
RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo '${TZ}' > /etc/timezone \
    && rm -rf /var/cache/apk/*
# 导入edge最新源
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
# 安装桌面环境并添加用户alpine
&& apk --update --no-cache add abiword audacious busybox dhcpcd dhcpcd-ui eudev evince gnumeric lxdm ristretto sudo xf86-video-vesa xfce4 xorg-server xscreensaver \
wget curl git x11vnc xvfb xrdp xauth firefox-esr xfce4 xfce4-terminal ttf-freefont wqy-zenhei supervisor sudo openssl openssh dbus bash python3 novnc \
&& addgroup alpine \
&& adduser  -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& echo "root:Docker!" | chpasswd \
&& rm -rf /tmp/* /var/cache/apk/*
# 使用entrypoint.sh，便于定制自己的镜像
COPY entrypoint.sh /usr/sbin/entrypoint.sh
ADD etc /etc
# 配置xrdp
RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
&& sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini \
&& ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

WORKDIR /home/alpine
ENV WEBSITES_PORT 6080
EXPOSE $WEBSITES_PORT 2222
USER alpine
ENTRYPOINT ["entrypoint.sh"]
