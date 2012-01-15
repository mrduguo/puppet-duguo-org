#!/bin/bash -ex
# Usage:
#
# wget -qO- https://raw.github.com/mrduguo/puppet-duguo-org/master/support/wget-data.sh | /bin/bash
#

apt-get -y install puppet
rm -rf /etc/puppet/* 

wget -qOpuppet-git-init.pp https://raw.github.com/mrduguo/puppet-duguo-org/master/support/puppet-git-init.pp
puppet apply -v puppet-git-init.pp
rm -f puppet-git-init.pp

