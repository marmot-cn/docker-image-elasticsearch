# docker-image-elasticsearch-5.6.8

---

## 简介

`elasticsearch`的`5.6.8`版本.

做了如下修改:

* 修改了时区为中国时区.
* 修改`elasticsearch`用户的属主和属组为`1040`.

## 部署示例

### 服务器ip

* 10.28.13.245
* 10.28.13.246
* 10.28.13.247

### 准备工作

```
sudo groupadd -g 1040 elasticsearch
sudo useradd elasticsearch -u 1040 -g elasticsearch
sudo mkdir -p /data/es/config
sudo mkdir -p /data/es/data
sudo mkdir -p /data/es/logs
sudo chown -R elasticsearch:elasticsearch /data/es/
```

### 部署代码

#### 10.28.13.245

```
docker run -d --net=host --name=es-1 -e ES_JAVA_OPTS="-Xms512m -Xmx512m" -v "/data/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" -v "/data/es/data:/usr/share/elasticsearch/data" -v "/data/es/logs:/usr/share/elasticsearch/logs" --cap-add=IPC_LOCK --ulimit memlock=-1:-1 --ulimit nofile=65536:65536 registry.cn-hangzhou.aliyuncs.com/marmot/elasticsearch-5.6.8
```

#### 10.28.13.246

```
docker run -d --net=host --name=es-2 -e ES_JAVA_OPTS="-Xms512m -Xmx512m" -v "/data/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" -v "/data/es/data:/usr/share/elasticsearch/data" -v "/data/es/logs:/usr/share/elasticsearch/logs" --cap-add=IPC_LOCK --ulimit memlock=-1:-1 --ulimit nofile=65536:65536 registry.cn-hangzhou.aliyuncs.com/marmot/elasticsearch-5.6.8
```

#### 10.28.13.247

```
docker run -d --net=host --name=es-3 -e ES_JAVA_OPTS="-Xms512m -Xmx512m" -v "/data/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" -v "/data/es/data:/usr/share/elasticsearch/data" -v "/data/es/logs:/usr/share/elasticsearch/logs" --cap-add=IPC_LOCK --ulimit memlock=-1:-1 --ulimit nofile=65536:65536 registry.cn-hangzhou.aliyuncs.com/marmot/elasticsearch-5.6.8
```

### 点配置文件

**`elasticsearch.yml`**

#### 10.28.13.245

```
cluster.name: yichang_es_cluster
node.name: es-1
node.master: true
node.data: true
http.port: 9222
transport.tcp.port: 9333
network.host: 10.28.13.245
network.bind_host: 10.28.13.245
network.publish_host: 10.28.13.245
transport.host: 10.28.13.245
discovery.zen.ping.unicast.hosts: 
 - 10.28.13.245:9333
 - 10.28.13.246:9333
 - 10.28.13.247:9333
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

```
sudo chown elasticsearch:elasticsearch /data/es/config/elasticsearch.yml
```

#### 10.28.13.246

```
cluster.name: yichang_es_cluster
node.name: es-2
node.master: true
node.data: true
http.port: 9222
transport.tcp.port: 9333
network.host: 10.28.13.246
network.bind_host: 10.28.13.246
network.publish_host: 10.28.13.246
transport.host: 10.28.13.246
discovery.zen.ping.unicast.hosts:  
 - 10.28.13.245:9333
 - 10.28.13.246:9333
 - 10.28.13.247:9333
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

```
sudo chown elasticsearch:elasticsearch /data/es/config/elasticsearch.yml
```

#### 10.28.13.247

```
cluster.name: yichang_es_cluster
node.name: es-3
node.master: true
node.data: true 
http.port: 9222
transport.tcp.port: 9333
network.host: 10.28.13.247
network.bind_host: 10.28.13.247
network.publish_host: 10.28.13.247
transport.host: 10.28.13.247
discovery.zen.ping.unicast.hosts:  
 - 10.28.13.245:9333
 - 10.28.13.246:9333
 - 10.28.13.247:9333
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

```
sudo chown elasticsearch:elasticsearch /data/es/config/elasticsearch.yml
```

## 参数说明:

* `network.publish_host`: 对外通信的ip,这里设置成宿主机的内网IP.
* `discovery.zen.ping.unicast.hosts`: 主节点搜索列表.
* `discovery.zen.minimum_master_nodes`: 根据算法节点数/2+1

## 检查

```
curl http://192.168.0.202:9222/_cat/nodes 
curl http://192.168.0.202:9222/_cluster/health
```

添加数据

```
curl -XPOST http://192.168.0.202:9222/zhouls/user/1 -d '{"name" : "john"  , "age" : 28}'
curl -XPOST http://192.168.0.202:9222/zhouls/user/2 -d '{"name" : "tony"  , "age" : 28}'

curl -XPOST http://192.168.0.202:9222/zhouls/user/_search?q=name:tony\&pretty
```