#
class ossec::client (
  $client_ip = undef
) inherits ossec::params {

    include concat::setup
    class { "ossec::service": }
    class { "ossec::config": install_type => "client" }

    include ossec::config::client

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

    if $client_ip == undef {
      $final_client_ip = $::ipaddress
    } else {
      $final_client_ip = $client_ip
    }

    ossec::clientkey { "ossec_key_${::fqdn}_client":
      client_id    => $::uniqueid,
      client_name  => $::fqdn,
      client_ip    => $final_client_ip,
      client_seed  => $ossec::params::client_seed
    }

    # send to server, requires storeconfigs
    @@ossec::clientkey { "ossec_key_${::fqdn}_server":
        client_id   => $::uniqueid,
        client_name => $::fqdn,
        client_ip   => $::ipaddress,
    }
}
