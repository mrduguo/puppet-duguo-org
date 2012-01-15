class xdir::pre-config {

    service { "shutdown-xdir" :
    	name		=> "xdir",
	    ensure 		=> stopped,
  	}

}