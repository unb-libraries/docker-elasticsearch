FROM unblibraries/oracle-jdk8
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y glusterfs-client

ENV ES_PKG_NAME elasticsearch-1.5.0

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Mount elasticsearch.yml config
ADD config/elasticsearch/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

EXPOSE 9200
EXPOSE 9300
