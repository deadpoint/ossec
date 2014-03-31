#
define ossec::config::syscheck::ignore {

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "syscheck_ignore_${name}":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '17',
      content => template("ossec/syscheck-ignore.erb"),
    }
}
