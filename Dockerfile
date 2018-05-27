FROM elasticsearch:5.6.8
RUN usermod -u 1040 elasticsearch && groupmod -g 1040 elasticsearch \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
