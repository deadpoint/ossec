class ossec::server (
    $enable_db  = $ossec::params::enable_db
    ) {

    include concat::setup
    class { "ossec::service": }
    class { "ossec::config": install_type => "server" }

    #
    package { 'ossec':
        name    => $ossec::params::server_package_name,
        ensure  => installed,
    }
    #
    concat { "${ossec::params::client_keys}":
        owner   => 'root',
        group   => $ossec::params::group,
        mode    => '0440',
        require => Package['ossec'],
        notify  => Class['Ossec::Service'],
    }
    # Add key from agent
    Ossec::Clientkey<<| |>>
}
