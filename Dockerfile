FROM unblibraries/jdk:oracle8
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y glusterfs-client

ENV ELASTICSEARCH_VERSION 1.5.0

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  tar xvzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  mv /elasticsearch-$ELASTICSEARCH_VERSION /elasticsearch

# Mount elasticsearch.yml config
ADD config/elasticsearch/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

# Clean-up
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9200
EXPOSE 9300
