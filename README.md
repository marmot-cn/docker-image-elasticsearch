# docker-image-elasticsearch-5.6.8

---

## 简介

`elasticsearch`的`5.6.8`版本.

做了如下修改:

* 修改了时区为中国时区.
* 修改`elasticsearch`用户的属主和属组为`1040`.


## 部署

### 服务器ip

* 10.28.13.245
* 10.28.13.246
* 10.28.13.247

```
docker run -d --name=es-x -p "9201:9200" -p "9301:9300" -v "/data/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" -v "/data/es/data:/usr/share/elasticsearch/data" -v "/data/es/logs:/usr/share/elasticsearch/logs" --cap-add=IPC_LOCK --ulimit memlock=-1:-1 --ulimit nofile=65536:65536 registry.cn-hangzhou.aliyuncs.com/marmot/elasticsearch-5.6.8 elasticsearch -Etransport.host=0.0.0.0 -Ediscovery.zen.minimum_master_nodes=1
```

### 主节点配置文件

**`elasticsearch.yml`**

```
cluster.name: elasticsearch_cluster
node.name: node-master
node.master: true
node.data: true
http.port: 9200
network.host: 10.28.13.245
transport.host: 0.0.0.0
network.publish_host: 10.28.13.245
discovery.zen.ping.unicast.hosts: ["10.28.13.245","10.28.13.246","10.28.13.247"]
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

### 子节点配置

**`elasticsearch.yml`**

#### 10.28.13.246

```
cluster.name: elasticsearch_cluster
node.name: node-data-x
node.master: true
node.data: true 
http.port: 9200
network.host: 10.28.13.246
transport.host: 0.0.0.0
network.publish_host: 10.28.13.246
discovery.zen.ping.unicast.hosts: ["10.28.13.245","10.28.13.246","10.28.13.247"]
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

#### 10.28.13.247

```
cluster.name: elasticsearch_cluster
node.name: node-data-x
node.master: true
node.data: true 
http.port: 9200
network.host: 0.0.0.0
transport.host: 0.0.0.0
network.publish_host: 10.28.13.247
discovery.zen.ping.unicast.hosts: ["10.28.13.245","10.28.13.246","10.28.13.247"]
discovery.zen.minimum_master_nodes: 2 
bootstrap.memory_lock=true
```

## 参数说明:

* `network.publish_host`: 对外通信的ip,这里设置成宿主机的内网IP.
* `discovery.zen.ping.unicast.hosts`: 主节点搜索列表.
* `discovery.zen.minimum_master_nodes`.