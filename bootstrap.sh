#!/bin/bash

function docker {
  apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-com \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
  apt-get update -y
  apt-get install docker-ce -y
}

function puppet {
  /opt/puppetlabs/puppet/bin/gem install r10k hiera-eyaml
  apt-get -y \
  install rsync curl wget git \
  curl -o /etc/puppetlabs/code/environments/production/Puppetfile \
  https://raw.githubusercontent.com/ppouliot/puppet-quartermaster/master/Puppetfile
  curl -o  /etc/puppetlabs/puppet/hiera.yaml \
  https://raw.githubusercontent.com/ppouliot/puppet-quartermaster/master/files/hiera/hiera.yaml
  cd /etc/puppetlabs/code/environments/production && /opt/puppetlabs/puppet/bin/r10k puppetfile install --verbose DEBUG2
  /opt/puppetlabs/bin/puppet apply --debug --trace --verbose \
  --modulepath=/etc/puppetlabs/code/environments/production/modules:/etc/puppetlabs/code/modules \
  /etc/puppetlabs/code/modules/quartermaster/examples/all.pp
}