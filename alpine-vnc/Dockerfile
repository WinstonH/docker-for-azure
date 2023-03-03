FROM alpine:edge
ENV TZ 'Asia/Shanghai'
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
&& apk upgrade --no-cache \
&& apk --update --no-cache add tzdata x11vnc xvfb openbox xfce4-terminal supervisor sudo bash firefox-esr ttf-freefont wqy-zenhei openssh novnc \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo '${TZ}' > /etc/timezone \
&& addgroup alpine \
&& adduser  -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& echo "root:Docker!" | chpasswd \
&& ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html \
&& rm -rf /tmp/* /var/cache/apk/*
ADD etc /etc
COPY entrypoint.sh /usr/sbin/entrypoint.sh 
WORKDIR /home/alpine

ENV WEBSITES_PORT 6080
EXPOSE $WEBSITES_PORT 2222

USER alpine
CMD entrypoint.sh
