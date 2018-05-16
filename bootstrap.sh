#! /usr/bin/env bash
#
# Install puppet5, docker and docker-compose.
# Supports Ubuntu 16.04.
#
# Usage: bootstrap.sh [puppet|docker|all]
#
# Leo Chan
#
function install_puppet {
  apt-get --purge autoremove puppetlabs-release
  apt-get update
  wget -cv http://apt.puppet.com/puppet5-release-xenial.deb \
  -O /tmp/puppet5-release-xenial.deb && dpkg -i /tmp/puppet5-release-xenial.deb
  apt-get install aptitude puppet-agent ruby -y
  gem install hiera-eyaml r10k
}
function install_docker {
  apt-get remove docker docker-engine docker.io -y
  apt-get update
  apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  apt-get update
  apt-get install docker-ce -y
}
function install_docker_compose {
  curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) \
  -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  curl -L https://raw.githubusercontent.com/docker/compose/1.21.2/contrib/completion/bash/docker-compose \
  -o /etc/bash_completion.d/docker-compose
}
case $1 in
  puppet)
    install_puppet
    ;;
  docker)
    install_docker; install_docker_compose
    ;;
  all)
    install_puppet; install_docker; install_docker_compose
    ;;
esac
