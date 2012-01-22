class xdir::pre-config {

	include params

	include sunjdk


    exec { "shutdown-xdir" :
      command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}