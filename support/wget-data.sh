#!/bin/bash -ex
#
# wget -qO- https://raw.github.com/mrduguo/puppet-duguo-org/master/support/wget-data.sh | /bin/bash
#

wget -qOpuppet-git-init.pp https://raw.github.com/mrduguo/puppet-duguo-org/master/support/puppet-git-init.pp

apt-get -y install puppet
rm -rf /etc/puppet/* 

puppet apply -v puppet-git-init.pp

rm -f puppet-git-init.pp
