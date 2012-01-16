class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${xdir::params::softwarePathCurrent}/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwarePathCurrent}/bin/xdir.sh",
	}
}