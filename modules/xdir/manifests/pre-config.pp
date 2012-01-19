class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "/etc/init.d/xdir stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}