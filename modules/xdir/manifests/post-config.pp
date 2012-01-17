class xdir::post-config {

	include params

    exec { "start-xdir" :
        command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh start",
        onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
    }
}