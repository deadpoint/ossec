#
class ossec::config::remote (
    $connection     = $ossec::params::connection,
    $port           = $ossec::params::port,
    $protocol       = $ossec::params::protocol,
    $allowed_ips    = $ossec::params::allowed_ips,
    $deny_ips       = $ossec::params::deny_ips,
    $local_ips      = $ossec::params::local_ips
    ) inherits ossec::params {

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::remote is for setting ossec server options only" )
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_remote":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '30',
      content => template("ossec/remote-options.erb"),
    }
}
