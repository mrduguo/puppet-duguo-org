node ubuntuserver inherits default {
    info("for ubuntuserver vm")
    host{
        name => "${hostname}",
        ip => "192.168.56.101",
    }
}