#
class ossec::config::client (
    $server_ip          = $ossec::params::server_ip,
    $server_hostname    = $ossec::params::server_hostname,
    $server_port        = $ossec::params::server_port,
    $notify_time        = $ossec::params::notify_time
    ) inherits ossec::params {

    include ossec::config

    if $ossec::config::install_type == "server" {
       fail( "ossec::config::client is for setting ossec client options only" )
    }

    if $server_ip == undef and $server_hostname == undef {
        fail("Either server_ip or server_hostname must be set")
    }

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_client":
        target  => "$content",
        order   => '05',
        content => template("ossec/client-options.erb"),
    }
}
