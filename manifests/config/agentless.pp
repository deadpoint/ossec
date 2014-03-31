#
class ossec::config::agentless (
    $frequency,
    $host,
    $state,
    $arguments
    ) inherits ossec::params {

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::agentless is for setting ossec server options only" )
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_agentless":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '40',
      content => template("ossec/agentless-options.erb"),
    }
}
