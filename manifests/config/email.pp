#
define ossec::config::email (
    $level              = undef,
    $group           	= undef,
    $event_location     = undef,
    $format             = undef,
    $rule_id            = undef,
    $do_not_delay       = undef,
    $do_not_group       = undef
    ) {

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::email is for setting ossec server options only" )
    }

    if $format { validate_re($format, '^(full|sms)$',
        "Invalid format, [$format] must be full or sms")
    }

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_email_${name}":
        target  => "$content",
        order   => '07',
        content => template("ossec/email-options.erb"),
    }
}
