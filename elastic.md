## ElasticSearch 101

elasticsearch: Auatomatically join cluster name
index: collection of dodcument, can be split into multiple shards
datatype:	catagory of index
document: json data
primary shard: original shards that were replicated from
replica shards: copies of primary shards
By default
	Each index is allocated 5 primary shards and 1 replica
	Automatically create the customer index if it didn’t already exist beforehand.
override cluster name or node name
 ./elasticsearch -Ecluster.name=my_cluster_name -Enode.name=my_node_name
 	- port 9200 for REST API
`curl -XGET 'localhost:9200`

## Install latest java
```
yum install -y java-1.8.0-openjdk
```

## Install Elasticsearch via yum
```
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
echo '[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md'|sudo tee /etc/yum.repos.d/elasticsearch.repo
yum install -y elasticsearch
systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch
## Install Kibana via yum
### https://www.elastic.co/guide/en/kibana/current/rpm.html
```
```
echo '[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md'|sudo tee /etc/yum.repos.d/kibana.repo
yum install -y kibana
systemctl daemon-reload
systemctl enable kibana && systemctl start kibana
### Optional: restrict to localhost only
```
echo server.host: "<ip address>" >> /usr/share/kibana/config/kibana.yml
yum -y install epel-release
```
```
## Install logstash and beats plugins
### https://www.elastic.co/guide/en/beats/libbeat/current/
### https://www.elastic.co/guide/en/logstash/current/installing-logstash.html
curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-5.2.2.rpm
yum localinstall logstash-5.2.2 -y 
systemctl start logstash && enable logstash
/usr/share/logstash/bin/logstash-plugin install logstash-input-beats
###  https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html
#### Use gork to parse unstructured log data into structured and queryable data
#### Logstash threading model: Input -> Queue -> Batcher -> Filter > Outputs
#### https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok
#### logstash search for logstash.yml in  
$LS_HOME/config
```

#### Filebeat Modules
filebeat -e -setup -modules='nginx'
filebeat -e -setup -modules='system'
#### topbeats - system statistics
#### winlogbeat - windows event logs
#### Monitor network connections with Packetbeat?!
#### Heartbeat metrics
 - Round Trip Times
 - tls handshake
### Filebeat (remote hosts) -> Logstash server(index) -> Elasticsearch <- Kibana

## Common API calls
### Cluster health
#### Green (fully functional)/ yellow (not yet replicated)/ red (partially functional)
`GET /_cat/health?v&pretty`
### Get list of nodes
`GET _cat/nodes?v&pretty`
### Create an index
`curl -XPUT 'localhost:9200/logs?pretty&pretty'`
### Index and create and document
`curl -XPUT 'localhost:9200/logs/external/1?pretty&pretty' -d'`
curl -XGET 'localhost:9200/logs/external/1?pretty&pretty'



