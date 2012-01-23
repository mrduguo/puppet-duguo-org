class xdir {

	include params

	stage { "pre": before => Stage["main"] }
	class { "pre-config" : stage => pre }

	stage { "post": require => Stage["main"] }
	class { "post-config" : stage => post }

    file {
      "/opt": ensure => directory;
      "${xdir::params::softwareHome}": ensure => directory;
      "${xdir::params::softwareHome}/dist": ensure => directory;
      "${xdir::params::softwareHome}/var": ensure => directory,
    }

    exec { "download-xdir" :
        command => "wget -qO- ${xdir::params::softwareDownloadUrl} | tar -xzf - -C ${xdir::params::softwareHome}/dist",
        creates => "${xdir::params::softwareHome}/dist/xdir-dist-bin-${xdir::params::softwareVersion}",
        logoutput => true,
        require => File["${xdir::params::softwareHome}/dist"],
    }

    file {"${xdir::params::softwareHome}/CURRENT":
        target => "${xdir::params::softwareHome}/dist/xdir-dist-bin-${xdir::params::softwareVersion}",
        ensure => link,
        subscribe => Exec["download-xdir"]
    }

    file{ "${xdir::params::softwareHome}/CURRENT/var":
        target => "${xdir::params::softwareHome}/var",
        ensure => link,
        subscribe => Exec["download-xdir"]
    }

    exec { "setup-data-folder" :
        command => "/bin/bash -c 'if [ -e ${xdir::params::softwareHome}/data ] ; then rm -rf ${xdir::params::softwareHome}/CURRENT/data; else mv ${xdir::params::softwareHome}/CURRENT/data ${xdir::params::softwareHome}/data; fi'",
        refreshonly => true,
        subscribe => File["${xdir::params::softwareHome}/CURRENT"],
    }

    file{"${xdir::params::softwareHome}/CURRENT/data":
        backup => false,
        target => "${xdir::params::softwareHome}/data",
        ensure => link,
        subscribe => Exec["setup-data-folder"],
    }

	file { "/etc/init.d/xdir":
		content   => template("xdir/service.erb"),
		mode    => 755,
        subscribe => Exec["setup-data-folder"],
	}

	file { "/opt/xdir/data/conf/osgi.properties":
		content   => template("xdir/osgi.properties.erb"),
        subscribe => Exec["setup-data-folder"],
	}

	file { "/opt/xdir/data/conf/xdir-service-http-jetty":
	    ensure => directory;
        subscribe => Exec["setup-data-folder"];
        "/opt/xdir/data/conf/xdir-service-http-jetty/local.xml":
        		content   => template("xdir/xdir-http-jetty-override.xml.erb"),
                subscribe => Exec["setup-data-folder"],
	}

}
