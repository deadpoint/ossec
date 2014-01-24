#
class ossec::config::remote (
    $connection     = $ossec::params::connection,
    $port           = $ossec::params::port,
    $protocol       = $ossec::params::protocol,
    $allowed_ips    = $ossec::params::allowed_ips,
    $deny_ips       = $ossec::params::deny_ips,
    $local_ips      = $ossec::params::local_ips
    ) inherits ossec::params {

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::remote is for setting ossec server options only" )
    }

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_remote":
        target  => "$content",
        order   => '30',
        content => template("ossec/remote-options.erb"),
    }
}
