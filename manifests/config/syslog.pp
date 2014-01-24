#
class ossec::config::syslog (
    $server,
    $port       = undef,
    $level      = undef,
    $group      = undef,
    $rule_id    = undef,
    $location   = undef,
    $format     = undef
    ) inherits ossec::params {

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::syslog is for setting ossec server options only" )
    }

    if $format { validate_re($format, '^(default|cef|json|splunk)$',
        "Invalid format, [$format] must be on of default, cef, json, or splunk")
    }
    if $level { validate_re($level, '^(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)$',
        "Invalid level, [$level] must be 1-16")
    }

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_syslog":
        target  => "$content",
        order   => '60',
        content => template("ossec/syslog-options.erb"),
    }
}
