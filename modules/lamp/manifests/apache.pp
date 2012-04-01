class apache {

  package { 'apache2' : ensure => installed }

  service {
    'apache2' :
    enable    => true,
    ensure    => running,
    subscribe => [Package['apache2']]
  }
  exec { "apache-graceful":
    command => undef,
    refreshonly => true,
    onlyif => undef,
  }
}