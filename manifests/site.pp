
node base {
    include screen
}

node default inherits base {
}

node ubuntuserver inherits default {
    info("for ubuntuserver vm")
}

node "duguo.org" inherits default {
    info("for duguo.org deployment")
}
