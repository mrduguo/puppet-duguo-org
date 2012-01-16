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

    file {
      "/opt": ensure => directory, owner => root;
      "/opt/xdir": ensure => directory, owner => xdir,require => User["xdir"];
      "/opt/xdir/dist": ensure => directory, owner => xdir,require => User["xdir"],
    }


    exec { "install-xdir" :
        command => "(wget -qO- ${softwareDownloadUrl} | tar -xzf - -C /opt/xdir/dist)",
        creates => "/opt/xdir/dist/xdir-dist-bin-${softwareVersion}",
        require => File["/opt/xdir/dist"],
    }

    file {"/opt/xdir/dist/xdir-dist-bin-${softwareVersion}":
        owner => xdir,
        recurse => true,
        require => Exec["install-xdir"],
    }

}
