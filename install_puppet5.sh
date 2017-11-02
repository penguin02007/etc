#! /bin/bash
curl https://apt.puppetlabs.com/puppet5-release-xenial.deb -o /tmp/puppet5-release-xenial.deb
apt-get install /tmp/puppet5-release-xenial.deb
apt-get update && apt-get install aptitude
# https://puppet.com/docs/puppet/5.3/install_linux.html
apt-cache show puppet-agent|grep -i 'puppet\s5' >>/dev/null && apt-get install puppet-agent -y
gem install r10k
r10k puppetfile install -v debug2 Puppetfile
