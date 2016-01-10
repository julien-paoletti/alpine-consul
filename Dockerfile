FROM alpine:latest

MAINTAINER Julien Paoletti <julien.paoletti@gmail.com>

# variable
ENV CONSUL_VERSION 0.6.1

# install wget HTTPS helper
RUN apk add --update ca-certificates

# installs consul binaries
RUN wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
RUN unzip consul_${CONSUL_VERSION}_linux_amd64.zip -d /bin/

# installs web ui binaries
RUN wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip
RUN mkdir -p /var/www/consul && unzip consul_${CONSUL_VERSION}_web_ui.zip -d /var/www/consul

# cleans
RUN  rm *.zip && rm /var/cache/apk/*

# adds config
COPY agent.json /etc/consul.d/
COPY server.json /etc/consul.d/

# launches the agent
ENTRYPOINT ["/bin/consul", "agent", "-server", "-bootstrap", "-config-dir=/etc/consul.d"]
