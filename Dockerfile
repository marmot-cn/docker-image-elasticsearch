FROM elasticsearch:5.6.8
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& apt-get update && apt-get install zip && rm -r /var/lib/apt/lists/* \
&& mkdir -p /usr/share/elasticsearch/plugins/ik && cd /usr/share/elasticsearch/plugins/ik \
&& wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.6.8/elasticsearch-analysis-ik-5.6.8.zip && unzip elasticsearch-analysis-ik-5.6.8.zip \
&& apt-get --purge -y remove zip 
