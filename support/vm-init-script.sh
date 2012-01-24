#!/bin/bash -ex
#
# You may run as logged user manually:
#
# wget -qO- https://raw.github.com/mrduguo/puppet-duguo-org/master/support/vm-init-script.sh | /bin/bash
#

apt-get -y install puppet
rm -rf /etc/puppet/* 

wget -qOpuppet-git-init.pp https://raw.github.com/mrduguo/puppet-duguo-org/master/support/puppet-git-init.pp
puppet apply -v puppet-git-init.pp
rm -f puppet-git-init.pp


wget -qO- https://github.com/mrduguo/puppet-duguo-org/tarball/master | tar -xzf -
mv *puppet-duguo-org*/* /etc/puppet
chown -R puppet /etc/puppet
rm -rf *puppet-duguo-org*
puppet apply -v /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules
