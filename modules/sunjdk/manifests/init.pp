class sunjdk {
	exec { "install-sunjdk":
      path => "/usr/bin:/usr/sbin:/bin",
  	  command => "aptitude -y install sun-java6-jdk",
  	  creates => "/usr/lib/jvm/java-6-sun/jre/bin/java",
	}
}
