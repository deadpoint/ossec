#
define ossec::config::activeres (
    $disabled           = undef
    $command           	= undef,
    $location           = undef,
    $agent_id           = undef,
    $level              = undef,
    $rules_group        = undef,
    $rules_id           = undef,
    $timeout            = undef,
    $repeated_offenders = undef,
    ) {

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::activeres is for setting ossec server options only" )
    }

    validate_re($location, '^(local|server|defined-agent|all)$',
        "Invalid location, [$location] must be on of local, server, defined-agent, or all")

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_activeres_${name}":
        target  => "$content",
        order   => '55',
        content => template("ossec/activeres-options.erb"),
    }
}
