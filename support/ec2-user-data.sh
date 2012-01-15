#!/bin/bash -ex

cat <<EOL > /etc/hosts
ssh-dss AAAAB3NzaC1kc3MAAACBAMHyWzr6fjlSA5ySICYHQCkl86alQdgzQrouva670C/d/YL72q+7QSYERQgrmOxX3T3heeIuQ7vt8jxgtPsvtDavAGZrTuwRGmWfbzWRpKFGOL+Bfxo/diM9rEbFKkbeFmmOKWzVnOA5J85jF9791Ilgr+L8IZIG8ojtiWsnMvqPAAAAFQCwq7q0ij46JSCfmwECHieKREJZQQAAAIA6GaPQjCkjdPI3VETZQnsqX+CyNTC2IFL/ge+Ror5JCU9MEt2yQK5EYPr6aRiTbsMM4ulzT51FMnaZ/Zd89IihNXKxRlwMa1CgqjQiKFVSztkIcTiPg8zSsS4YwxUBAAA4EeL7nnxN2i48COlWboilCag9IhuktdL0Zt36e48/cwAAAIAzfG502vZADKm88JWm/KuQsVxMKC8ENxP5fTE1Qr0W53ahIRcZcWEpRMzEJ4+M1yWhf+PMufbwxOyPtK2mDy+cADwTZ6tlaolOuDbv8CIMa9qy50E9lyYkA78OLj/CqlJfch2rQu8IfdsYe2QjlOiYcEmWKh71rWe2I05GlKSAdQ== gdu
127.0.0.1 localhost.localdomain localhost
10.1.1.1  puppetmaster

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
EOL

wget -qO/usr/bin/runurl mrduguo.github.com/scripts/runurl_by_alestic
chmod 755 /usr/bin/runurl


apt-get -y install puppet
apt-get -y install git
apt-get -y install python-software-properties
add-apt-repository -y ppa:ferramroberto/java
apt-get update
echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install sun-java6-jdk


runurl ec2web.mycompany.com/upgrade/apt
runurl ec2web.mycompany.com/customize/ssh
runurl ec2web.mycompany.com/customize/vim
runurl ec2web.mycompany.com/install/puppet
