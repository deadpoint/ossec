#
class ossec::config::syscheck (
    $directories      	= $ossec::params::directories,
    $frequency        	= $ossec::params::frequency,
    $ignore        	= $ossec::params::ignore,
    $scan_time        	= $ossec::params::scan_time,
    $scan_day        	= $ossec::params::scan_day,
    $auto_ignore        = $ossec::params::auto_ignore,
    $alert_new_files    = $ossec::params::alert_new_files,
    $scan_on_start      = $ossec::params::scan_on_start,
    $windows_registry	= $ossec::params::windows_registry,
    $registry_ignore    = $ossec::params::registry_ignore,
    $refilter_cmd       = $ossec::params::refilter_cmd
    ) inherits ossec::params {

    #is_integer($frequency,
    #    "Invalid frequency, [$frequency] must be time in seconds")
    #validate_re($scan_day, '^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)$',
    #    "Invalude scan_day, [$scan_day] must be sunday,monday,tuesday, etc")

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_syscheck":
        target  => "$content",
        order   => '10',
        content => template("ossec/syscheck-options.erb"),
    }
}
