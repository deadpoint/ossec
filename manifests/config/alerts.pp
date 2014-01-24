#
class ossec::config::alerts (
    $email_alert_level = undef,
    $log_alert_level   = undef,
    $use_geoip         = undef
    ) inherits ossec::params {

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::alerts is for setting ossec server options only" )
    }

    if $email_alert_level { validate_re($email_alert_level, '^(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)$',
        "Invalid email_alert_level, [$email_alert_level] must be 1-16")
    }
    if $log_alert_level { validate_re($log_alert_level, '^(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)$',
        "Invalid log_alert_level, [$log_alert_level] must be 1-16")
    }

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_alerts":
        target  => "$content",
        order   => '06',
        content => template("ossec/alerts-options.erb"),
    }
}
