FROM elasticsearch:7.16.1
RUN usermod -u 1040 elasticsearch && groupmod -g 1040 elasticsearch \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
