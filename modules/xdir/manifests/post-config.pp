class xdir::post-config {

	include params

    exec { "start-xdir" :
        command => "${softwarePathCurrent}/bin/xdir.sh start",
        onlyif => "test -f ${softwarePathCurrent}/bin/xdir.sh",
    }
}