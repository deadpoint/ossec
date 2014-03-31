#
class ossec::config::client (
    $server_ip          = $ossec::params::server_ip,
    $server_hostname    = $ossec::params::server_hostname,
    $server_port        = $ossec::params::server_port,
    $notify_time        = $ossec::params::notify_time
    ) inherits ossec::params {

    if $ossec::config::install_type == "server" {
      fail( "ossec::config::client is for setting ossec client options only" )
    }

    if $server_ip == undef and $server_hostname == undef {
      fail("Either server_ip or server_hostname must be set")
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_client":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '05',
      content => template("ossec/client-options.erb"),
    }
}
