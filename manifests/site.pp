
node base {
    include screen
}

node default inherits base {
}

node ubuntuserver inherits default {
    info("for ubuntuserver vm")
}
