#
define ossec::config::command (
    $executable      = undef,
    $expect          = undef,
    $timeout_allowed = undef
    ) {

    validate_re($timeout_allowed, '^(yes|no)$',
        "Invalid timeout_allowed, [$timeout_allowed], must be one of the following values: yes or no")

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_command_${name}":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '50',
      content => template("ossec/command-options.erb"),
    }
}
