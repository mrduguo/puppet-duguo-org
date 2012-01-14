#!/bin/sh
git --work-tree /etc/puppet checkout -f
sudo puppet apply -v /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules
