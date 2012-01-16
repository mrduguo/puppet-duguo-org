class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${softwarePathCurrent}/abin/xdir.sh stop",
      onlyif => "test -f ${softwarePathCurrent}/bbin/xdir.sh",
	}
}