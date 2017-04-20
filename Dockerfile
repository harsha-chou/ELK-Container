FROM ubuntu:16.04
RUN apt-get update && apt-get upgrade -y && apt-get install software-properties-common python-software-properties -y
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update && apt-get -y install oracle-java8-installer -yes
#Elasticsearch
RUN apt-get -qq install -y wget
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apt-get update
RUN apt-get -y install elasticsearch
COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN service elasticsearch restart
RUN update-rc.d elasticsearch defaults 95 10
#kibana
RUN echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.4.x.list
RUN apt-get update
RUN sudo apt-get -y install kibana
COPY kibana.yml /opt/kibana/config/kibana.yml
RUN update-rc.d kibana defaults 96 9
RUN service kibana start
RUN apt-get install nginx apache2-utils
RUN htpasswd -c /etc/nginx/htpasswd.users admin
RUN 
LABEL version="1.0"
EXPOSE 80 9200 9300 5601 5044
