#
class ossec::client {

    include concat::setup
    class { "ossec::service": }
    class { "ossec::config": install_type => "client" }

    package { 'ossec':
        ensure  => installed,
        name    => $ossec::params::client_package_name,
    }
    #
    concat { "${ossec::params::client_keys}":
        owner   => 'root',
        group   => $ossec::params::group,
        mode    => '0440',
        require => Package['ossec'],
        notify  => Class['Ossec::Service'],
    }
    # set key on the client
    ossec::clientkey { "ossec_key_${::fqdn}_client":
        client_id   => $::uniqueid,
        client_name => $::fqdn,
        client_ip   => $::ipaddress,
    }
    # send to server, requires storeconfigs
    @@ossec::clientkey { "ossec_key_${::fqdn}_server":
        client_id   => $::uniqueid,
        client_name => $::fqdn,
        client_ip   => $::ipaddress,
    }
}
