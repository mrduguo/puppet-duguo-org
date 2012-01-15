class sunjdk {
	exec { "install-sunjdk1":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "apt-get -y install python-software-properties"
	}
	
	exec { "install-sunjdk2":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "add-apt-repository -y ppa:ferramroberto/java"
	}
	
	exec { "install-sunjdk3":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "apt-get update"
	}
	
	exec { "install-sunjdk5":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections"
	}
	
	exec { "install-sunjdk6":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "apt-get -y install sun-java6-jdk",
  	  creates => "/usr/lib/jvm/java-6-sun/jre/bin/java"
	}
}
