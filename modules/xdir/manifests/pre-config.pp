class xdir::pre-config {

	include params

	include sunjdk

	file { "/etc/iptables/rules":
		content   => template("xdir/iptable-rules.erb"),
	}

    $iptables_config = "file"
	include iptables

    exec { "shutdown-xdir" :
      command => "${xdir::params::softwareHome}/CURRENT/bin/xdir.sh stop",
      onlyif => "test -f ${xdir::params::softwareHome}/CURRENT/bin/xdir.sh",
	}
}