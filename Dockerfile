FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.22
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
