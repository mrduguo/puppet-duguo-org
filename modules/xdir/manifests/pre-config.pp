class xdir::pre-config {

	include params

	include sunjdk

	iptables::rule{"foward-port-80-to-8080":
	    rule => '-t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 8080',
	}

	include iptables

    exec { "shutdown-xdir" :
      command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}