# unblibraries/elasticsearch
Docker container : leverages phusion/baseimage and glusterfs storage to deploy a clustered elasticsearch node.

## Usage
```
/usr/bin/docker run --rm \
    --name %p-%i \
    -p 9200:9200 \
    -p 9300:9300 \
    -e GLUSTER_VOL=elasticsearch_lib_unb_ca_%H \
    -e GLUSTER_VOL_PATH=/mnt/elasticsearch_lib_unb_ca_%H \
    -e GLUSTER_PEER="192.168.2.15 192.168.2.16" \
    -e GLUSTER_FILESYSTEM_LINK_DATA="/data/elasticsearch,/data" \
    --add-host='gluster0.host.com:192.168.2.15' \
    --add-host='gluster1.host.com:192.168.2.16' \
    -e ELASTICSEARCH_NODE_NAME=%H \
    -e ELASTICSEARCH_CLUSTER_NAME=unblibsystemslogstash \
    -e ELASTICSEARCH_PUBLISH_HOST=${COREOS_PRIVATE_IPV4} \
    -e ELASTICSEARCH_MULTICAST_ENABLED=false \
    -e ELASTICSEARCH_UNICAST_HOSTS=192.168.2.200:9300,192.168.2.201:9300 \
    --cap-add=SYS_ADMIN \
    --device /dev/fuse:/dev/fuse:mrw \
    unblibraries/elasticsearch
```

## Runtime/Environment Variables
* `GLUSTER_VOL` - (Required) The name of the GlusterFS volume to mount as the database storage.
* `GLUSTER_VOL_PATH` - (Required) The container location to mount the gluster volume.
* `GLUSTER_PEER` - (Required) A space or comma separated list of gluster peers to use for the mount. All gluster peers must have hostnames that resolve within the container, or else have host entries defined at runtime (See below).
* `GLUSTER_FILESYSTEM_LINK_DATA` - (Required) A space separated list of volume/container link points. This will create symlinks from the container storage to the gluster mount, deleting anything that exists in the container by default.
* `ELASTICSEARCH_NODE_NAME` - (Required) Name for the elasticsearch node. Typically the hostname, which can be populated in a fleet service with %H.
* `ELASTICSEARCH_CLUSTER_NAME` - (Required) Unique cluster name for your cluster.
* `ELASTICSEARCH_PUBLISH_HOST` - (Required) The private (LAN) ip host for your elasticsearch node.
* `ELASTICSEARCH_MULTICAST_ENABLED` - (Required) Always `false`, since multicast does not work with docker currently.
* `ELASTICSEARCH_UNICAST_HOSTS` - (Required) A list of the private (LAN) ips of all elasticsearch nodes. This can be populated automatically in a coreos cluster by [leveraging etcd and deploying a discovery service](http://mattupstate.com/coreos/devops/2014/06/26/running-an-elasticsearch-cluster-on-coreos.html).

## License
- unblibraries/elasticsearch is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Elasticsearch Cluster Docker Container by UNB Libraries`
