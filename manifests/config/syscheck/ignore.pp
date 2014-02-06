#
define ossec::config::syscheck::ignore {

    $content = "${ossec::params::conf_file}"

    concat::fragment { "syscheck_ignore${name}":
        target  => "$content",
        order   => '17',
        content => template("ossec/syscheck-ignore.erb"),
    }
}
