class xdir::post-config {

	include params

    exec { "start-xdir" :
      command => "${softwarePathCurrent}/bin/xdir.sh start",
      unless => "ls ${softwarePathCurrent}/bin/xdir.sh"
	}
}