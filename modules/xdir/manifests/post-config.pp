class xdir::post-config {

	include params

    exec { "start-xdir" :
        command => "${xdir::params::softwarePathCurrent}/bin/xdir.sh start",
        onlyif => "test -f ${xdir::params::softwarePathCurrent}/bin/xdir.sh",
    }
}