class xdir::post-config {

    include params

    service { "restart-xdir" :
    	name		=> "xdir",
	    enable 		=> true,
	    hasstatus 	=> true,
	    hasrestart 	=> true,
	    ensure 		=> running,
  	}

}