#!/bin/sh
git --work-tree /etc/puppet checkout -f
sudo puppet apply /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules
