user { "git":
  ensure => "present",
  home => "/home/git",
  shell => "/bin/bash",
}


file {
  "/home/git": ensure => directory, owner => git, 
  require => User["git"];
  "/home/git/puppet.git": ensure => directory, owner => git, 
  require => [User["git"], File["/home/git"]],
}

ssh_authorized_key { "git":
  ensure => present,
  user => git,
  key => "AAAAB3NzaC1kc3MAAACBAIxgAzxAPJ/oUgUE71/6SPfDYiaL3QUX6k08LUgD3ZDDA5xxnknNUslEhFTNejvivnJUbzx4GDjMdWlMAJOiLPJGkn9lZzWG2bE+5B6c7mEufg0ALfh46o9wLB7JMd20XpYmqRpYpes1iegKGa+bkDdyoaxddj04jLYCaIJteNpdAAAAFQD7QZEmRJ771P+xl1VXNpnRPTpzhQAAAIAn9hYo3NSD1oFROlana20bJlw9hN65jaYjNsEZRlewBWSPxPdI1b9A+9yGNRRYRKLiQZBVDi2CpjqLqoB0JgxRZ3gz1E0IgIGLGgy1V7tBfid+Vd5jgjAvMxn8XZre3cFhG+k3mMQdQ5omj1iosNq1C7Aj/nSikyIW+Ti5a5c6bwAAAIEAiTm5faFz/Y4EsfWfqgqFrOAro4y+BV2149EGFuYIi9VQX1VNen4tM4nZ1P5Tth4/MH5aDdOBCf+hKp0lVyW2sMLajsoh0JqY79D/0D4k6vgcKRIYKtuKtlzN0Y5nVAZPGUqhhVUzmPouN3iPooixyXGBg59mwgadr/+Vc/SV1Ic=",
  name => "mrduguo@duguo.org",
  target => "/home/git/.ssh/authorized_keys",
  type => ssh-dss,
  require => File["/home/git"],
}

package { "git":
  ensure => installed,
}

exec { "init-git-repo":
  cwd => "/home/git/puppet.git",
  user => "git",
  command => "/usr/bin/git init --bare",
  creates => "/home/git/puppet.git/HEAD",
  require => [File["/home/git/puppet.git"], Package["git"], User["git"]],
}

$postreceive = "#!/bin/sh
git --work-tree /etc/puppet checkout -f
sudo puppet apply -v /etc/puppet/manifests/site.pp --modulepath=/etc/puppet/modules"

file { "/home/git/puppet.git/hooks/post-receive":
	content => $postreceive,
    mode => 755,
    owner => git,
  require => [Exec["init-git-repo"]],
}

exec { "echo 'git ALL= NOPASSWD: /usr/bin/puppet' >> /etc/sudoers":
    path => "/usr/bin:/usr/sbin:/bin",
    unless => "grep puppet /etc/sudoers 2>/dev/null"
}