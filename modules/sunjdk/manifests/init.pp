class sunjdk {
	exec { "install-sunjdk6":
      path => "/usr/bin:/usr/sbin:/bin",
      logoutput => true,
  	  command => "apt-get -y install sun-java6-jdk",
  	  creates => "/usr/lib/jvm/java-6-sun/jre/bin/java"
	}
}
