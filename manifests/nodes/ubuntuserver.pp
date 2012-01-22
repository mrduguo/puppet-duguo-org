node ubuntuserver inherits default {
    info("for ubuntuserver vm")
    host{"${hostname}":
        ip => "192.168.56.101",
    }
}