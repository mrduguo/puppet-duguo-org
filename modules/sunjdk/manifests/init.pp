class sunjdk {
	exec { "install-sunjdk":
      command => "apt-get -y install python-software-properties && add-apt-repository -y ppa:ferramroberto/java && apt-get update &&  echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections && apt-get -y install sun-java6-jdk",
  	  creates => "/usr/lib/jvm/java-6-sun/jre/bin/java"
	}
}
