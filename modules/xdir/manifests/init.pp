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
      "${xdir::params::softwareHome}/dist": ensure => directory, owner => xdir,require => User["xdir"],
      "${xdir::params::softwareHome}/data": ensure => directory, owner => xdir,require => User["xdir"],
      "${xdir::params::softwareHome}/var": ensure => directory, owner => xdir,require => User["xdir"],
    }


    exec { "install-xdir" :
        command => "(wget -qO- ${xdir::params::softwareDownloadUrl} | tar -xzf - -C ${xdir::params::softwarePathUnpack}) || chown -R xdir ${xdir::params::softwarePathUnpack}/xdir-dist-bin-${xdir::params::softwareVersion}",
        creates => "${xdir::params::softwarePathUnpack}/xdir-dist-bin-${xdir::params::softwareVersion}",
        logoutput => true,
        require => File["/opt/xdir/dist"],
    }

    file {"${xdir::params::softwarePathCurrent}":
        owner => xdir,
        target => "${xdir::params::softwarePathUnpack}/xdir-dist-bin-${xdir::params::softwareVersion}",
        ensure => link,
        require => Exec["install-xdir"];
        "${xdir::params::softwarePathCurrent}/data":
        owner => xdir,
        target => "${softwarePathData}",
        ensure => link,
        require => Exec["install-xdir"],
    }

}
