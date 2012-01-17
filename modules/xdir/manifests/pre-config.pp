class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${xdir::params::softwarePathHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwarePathHome}/CURRENT/bin/xdir.sh",
	}
}