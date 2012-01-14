#!/bin/sh
git --work-tree /etc/puppet checkout -f
sudo puppet apply /etc/puppet/hellowolrd.pp
