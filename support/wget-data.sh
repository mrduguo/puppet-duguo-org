#!/bin/bash -ex

wget -qOpuppet-git-init.pp https://raw.github.com/mrduguo/puppet-duguo-org/master/support/puppet-git-init.pp

apt-get -y install puppet

puppet apply -v puppet-git-init.pp

rm -f puppet-git-init.pp
