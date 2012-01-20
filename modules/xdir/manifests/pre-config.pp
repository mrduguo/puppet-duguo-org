class xdir::pre-config {

	include params

	include sunjdk

	include iptables

	iptables::rule{"foward-port-80-to-8080":
	    rule => '-t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 8080',
	}

    exec { "shutdown-xdir" :
      command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}