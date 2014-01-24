#
define ossec::config::localfile (
    $frequency        	= $ossec::params::frequency,
    $log_format 	= $ossec::params::log_format,
    $command           	= $ossec::params::command,
    $ossec_alias        = $ossec::params::ossec_alias,
    $check_diff         = $ossec::params::check_diff
    ) {

    validate_re($log_format, '^(syslog|snort-full|snort-fast|squid|iis|eventlog|mysql_log|postgresql_log|nmapg|apache|command|full_command|djb-multilog|multi-line)$',
        "Invalid log_format, [$log_format] must be one of: syslog,snort-full,snort-fast,squid,iis,eventlog,mysql_log,postgresql_log,nmapg,apache,command,full_command,djb-multilog,multi-line")

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_localfile_${name}":
        target  => "$content",
        order   => '15',
        content => template("ossec/localfile-options.erb"),
    }
}
