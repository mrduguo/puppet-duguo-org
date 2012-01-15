import "globals.pp"

node base {
    include screen
    include sunjdk
}

node default inherits base {
}

node ubuntuserver inherits default {
    info("for ubuntuserver vm")
}

node "duguo.org" inherits default {
    info("for duguo.org deployment")
}
