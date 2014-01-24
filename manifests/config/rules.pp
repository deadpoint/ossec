#
define ossec::config::rules (
    ) {

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::rules is for setting ossec server options only" )
    }

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_rules_${name}":
        target  => "$content",
        order   => '23',
        content => template("ossec/rules-options.erb"),
    }
}
