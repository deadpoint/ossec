#
class ossec::config::agentless (
    $frequency,
    $host,
    $state,
    $arguments
    ) inherits ossec::params {

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::agentless is for setting ossec server options only" )
    }

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_agentless":
        target  => "$content",
        order   => '40',
        content => template("ossec/agentless-options.erb"),
    }
}
