class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${softwarePathCurrent}/bin/xdir.sh stop",
      onlyif => "test -f ${softwarePathCurrent}/bin/xdir.sh",
	}
}