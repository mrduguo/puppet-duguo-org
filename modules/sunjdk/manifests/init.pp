class sunjdk {
	exec { "install-sunjdk":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "apt-get -y install  python-software-properties",
  	  creates => "/usr/lib/jvm/java-6-sun/jre/bin/java"
	}
}
