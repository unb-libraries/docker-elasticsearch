#!/usr/bin/env bash

cat <<EOT >> /elasticsearch/config/elasticsearch.yml
node.name: $ELASTICSEARCH_NODE_NAME
cluster.name: $ELASTICSEARCH_CLUSTER_NAME
network.publish_host: $ELASTICSEARCH_PUBLISH_HOST
discovery.zen.ping.multicast.enabled: $ELASTICSEARCH_MULTICAST_ENABLED
discovery.zen.ping.unicast.hosts: $ELASTICSEARCH_UNICAST_HOSTS
EOT
