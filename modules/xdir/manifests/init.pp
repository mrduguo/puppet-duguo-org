class xdir {

	include params

	stage { "pre": before => Stage["main"] }
	class { "sunjdk" : stage => pre }
	class { "pre-config" : stage => pre }

	stage { "post": require => Stage["main"] }
	class { "post-config" : stage => post }

	user { "xdir":
      ensure => "present",
      home => "${softwareHome}",
      shell => "/bin/false",
    }


	exec { "install-xdir":
      command => "echo a",
  	  creates => "$softwarePathUnpack}"
	}
}
