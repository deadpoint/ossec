#
define ossec::config::rules (
      $order
    ) {

    if $name == "rules_config.xml" {
      fail("Ossec rule [$name] is included by default, remove it from the manifest" )
    }

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::rules is for setting ossec server options only" )
    }

    $rule_order = 2001

    if $order {
      $rul_num = ( $rule_order + $order )
    } else {
      $rul_num = $rule_order
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_rules_${name}":
      ensure  => 'present',
      target  => "$conf_file",
      order   => "${rul_num}",
      content => template("ossec/rules-options.erb"),
    }
}
