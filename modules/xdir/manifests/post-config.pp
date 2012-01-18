class xdir::post-config {

	include params

    exec { "start-xdir" :
        command => "/etc/init.d/xdir start",
        onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
    }
}