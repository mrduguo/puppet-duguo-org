class xdir::pre-config {

	include params

	include sunjdk

	file { "/etc/iptables/rules.v4":
		content   => template("xdir/iptable-rules.erb"),
	}

	include iptables


    exec { "shutdown-xdir" :
      command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}