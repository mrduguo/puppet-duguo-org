class xdir::post-config {

	include params

    exec { "start-xdir" :
        command => "${xdir::params::softwarePathHome}/CURRENT/bin/xdir.sh start",
        onlyif => "test -f ${xdir::params::softwarePathHome}/CURRENT/bin/xdir.sh",
    }
}