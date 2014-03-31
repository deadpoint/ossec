#
define ossec::config::localfile (
    $frequency          = $ossec::params::frequency,
    $log_format         = $ossec::params::log_format,
    $command            = undef,
    $ossec_alias        = undef,
    $check_diff         = undef
    ) {

    validate_re($log_format, '^(syslog|snort-full|snort-fast|squid|iis|eventlog|mysql_log|postgresql_log|nmapg|apache|command|full_command|djb-multilog|multi-line)$',
        "Invalid log_format, [$log_format], must be one of the following values: syslog,snort-full,snort-fast,squid,iis,eventlog,mysql_log,postgresql_log,nmapg,apache,command,full_command,djb-multilog,multi-line")

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_localfile_${name}":
        target  => "$content",
        order   => '15',
        content => template("ossec/localfile-options.erb"),
    }
}
