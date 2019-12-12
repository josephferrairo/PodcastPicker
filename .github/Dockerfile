FROM ruby:2.6.5

# Install Dependencies
RUN apt-get update && \
      apt-get install -y software-properties-common && \
      apt-get install -y build-essential && \
      apt-get install -y curl git vim bash wget cmake jq && \
      apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev sudo libpq-dev && \
      apt-get install -y python-selenium python3-selenium && \
      mkdir actions-runner && cd actions-runner && \
      curl -O https://githubassets.azureedge.net/runners/2.160.2/actions-runner-linux-x64-2.160.2.tar.gz && \
      tar xzf ./actions-runner-linux-x64-2.160.2.tar.gz && \
      ./bin/installdependencies.sh

# Install docker client
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 19.03.5
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
      | tar -xzC /usr/local/bin --strip=1 docker/docker

# Set environment variables.
ENV HOME /root
ENV AGENT_ALLOW_RUNASROOT 1
ENV GEM_PATH /usr/local
ENV GEM_HOME /usr/local

CMD ["bash"]
ENTRYPOINT ["/bin/bash", "-l", "-c"]
