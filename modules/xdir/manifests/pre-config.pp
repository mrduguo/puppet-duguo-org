class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${softwarePathCurrent}/abin/xdir.sh stop",
      unless => "ls ${softwarePathCurrent}/bbin/xdir.sh"
	}
}