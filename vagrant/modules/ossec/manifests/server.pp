class ossec::server (
    $enable_db        = $ossec::params::enable_db,
    $enable_debug     = $ossec::params::enable_debug,
    $enable_agentless = $ossec::params::enable_agentless,
    $enable_csyslog   = $ossec::params::enable_csyslog
    ) inherits ossec::params {

    include concat::setup

    class { "ossec::service": }
    class { "ossec::config": install_type => "server" }

    include ossec::config::remote
    include ossec::config::global

    #
    package { 'ossec':
        name    => $ossec::params::server_package_name,
        ensure  => installed,
    }
    #
    file { 'pfile':
        path    => $ossec::params::plist_file,
        ensure  => file,
        owner   => $ossec::params::user,
        group   => $ossec::params::group,
        mode    => '0644',
        content => template("ossec/process_list.erb"),
        require => Package['ossec'],
        notify  => Class['Ossec::Service'],
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
