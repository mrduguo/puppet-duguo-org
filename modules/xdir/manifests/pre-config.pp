class xdir::pre-config {

	include params

    exec { "shutdown-xdir" :
      command => "${softwarePathCurrent}/bin/xdir.sh stop",
      unless => "ls ${softwarePathCurrent}/bin/xdir.sh"
	}
}