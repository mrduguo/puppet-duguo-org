class helloworld {
   info("hello world from  $environment $hostname")
   host{"foo.bar":
      ip => "127.0.0.7",
   }
   augeas { "sshd_config":
	  changes => [
	    "set /files/etc/ssh/sshd_config/PermitRootLogin yes",
	  ],
	}

}

class helloworld::again {
   info("hello world again")
}


node base {
    include screen
    include helloworld
}


node default inherits base {
    include helloworld::again
}
node xubuntuserver inherits default {
    include helloworld::again
    info("for ubuntu server")
}
