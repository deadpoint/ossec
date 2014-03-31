#
class ossec::config::syscheck (
    $frequency          = $ossec::params::frequency,
    $scan_time          = $ossec::params::scan_time,
    $scan_day           = $ossec::params::scan_day,
    $auto_ignore        = $ossec::params::auto_ignore,
    $alert_new_files    = $ossec::params::alert_new_files,
    $scan_on_start      = $ossec::params::scan_on_start,
    $windows_registry   = $ossec::params::windows_registry,
    $registry_ignore    = $ossec::params::registry_ignore,
    $prefilter_cmd      = $ossec::params::prefilter_cmd
    ) inherits ossec::params {

    if $scan_day {
        validate_re($scan_day, '^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)$',
            "Invalid scan_day, [$scan_day], must be sunday, monday, tuesday, etc")
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_syscheck":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '11',
      content => template("ossec/syscheck-options.erb"),
    }
}
