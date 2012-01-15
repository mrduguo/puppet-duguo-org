class sunjdk {
	exec { "install-sunjdk":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "apt-get -y install python-software-properties && add-apt-repository -y ppa:ferramroberto/java && apt-get update && echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections && apt-get -y install sun-java6-jdk",
  	  unless => "grep xpuppet /etc/sudoers 2>/dev/null"
	}
}
