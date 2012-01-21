#
# Class: iptables
#
# Manages iptables.
#
# Usage:
# include iptables
#
class iptables {

    # Load the variables used in this module. Check the params.pp file
    require iptables::params

    case $operatingsystem {
        debian: { require iptables::debian }
        ubuntu: { require iptables::debian }
        default: { }
    }

    # Basic Package - Service - Configuration file management
    package { "iptables":
        name   => "${iptables::params::packagename}",
        ensure => present,
    }

    service { "iptables":
        name       => "${iptables::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => false,
        restart    => inline_template("iptables-restore < <%= scope.lookupvar('iptables::params::configfile') %>"),
        hasstatus  => "${iptables::params::hasstatus}",
        require    => Package["iptables"],
    }

    include iptables::file

    # Include project specific class if $my_project is set
    if $my_project { include "iptables::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include iptables::debug }

}
