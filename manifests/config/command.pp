#
define ossec::config::command (
    $executable
    $expect           	= "",
    $timeout_allowed    = undef
    ) {

    validate_re($timeout_allowed, '^(yes|no)$',
        "Invalid timeout_allowed, [$timeout_allowed] must be yes or no")

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_command_${name}":
        target  => "$content",
        order   => '50',
        content => template("ossec/command-options.erb"),
    }
}
