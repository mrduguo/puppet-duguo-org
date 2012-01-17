class xdir {

	include params
    info("(${xdir::params::softwareHome},${xdir::params::softwareDownloadUrl},${xdir::params::softwareVersion})")

	stage { "pre": before => Stage["main"] }
	class { "sunjdk" : stage => pre }
	class { "pre-config" : stage => pre }

	stage { "post": require => Stage["main"] }
	class { "post-config" : stage => post }

	user { "xdir":
      ensure => "present",
      home => "${xdir::params::softwareHome}",
      shell => "/bin/false",
    }

    file {
      "/opt": ensure => directory, owner => root;
      "${xdir::params::softwareHome}": ensure => directory, owner => xdir,require => User["xdir"];
      "${xdir::params::softwareHome}/dist": ensure => directory, owner => xdir,require => User["xdir"];
      "${xdir::params::softwareHome}/var": ensure => directory, owner => xdir,require => User["xdir"],
    }


    exec { "download-xdir" :
        command => "wget -qO- ${xdir::params::softwareDownloadUrl} | tar -xzf - -C ${xdir::params::softwareHome}/dist || chown -R xdir ${xdir::params::softwareHome}/dist/xdir-dist-bin-${xdir::params::softwareVersion}",
        creates => "${xdir::params::softwareHome}/dist/xdir-dist-bin-${xdir::params::softwareVersion}",
        logoutput => true,
        require => File["${xdir::params::softwareHome}/dist"],
    }

    file {"${xdir::params::softwareHome}/CURRENT":
        owner => xdir,
        target => "${xdir::params::softwareHome}/dist/xdir-dist-bin-${xdir::params::softwareVersion}",
        ensure => link,
        require => Exec["download-xdir"]
    }
    file{ "${xdir::params::softwareHome}/CURRENT/var":
        owner => xdir,
        target => "${xdir::params::softwareHome}/var",
        ensure => link,
        require => Exec["download-xdir"]
    }

    exec { "setup-data-folder" :
        command => "/bin/bash -c 'if [ -f ${xdir::params::softwareHome}/data ] ; then rm -rf ${xdir::params::softwareHome}/CURRENT/data; else mv ${xdir::params::softwareHome}/CURRENT/data ${xdir::params::softwareHome}/data; fi'",
        require => File["${xdir::params::softwareHome}/CURRENT"],
    }
    file{"${xdir::params::softwareHome}/CURRENT/data":
        owner => xdir,
        target => "${xdir::params::softwareHome}/data",
        ensure => link,
        require => Exec["setup-data-folder"],
    }

}
