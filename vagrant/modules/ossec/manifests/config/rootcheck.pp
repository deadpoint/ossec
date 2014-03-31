#
class ossec::config::rootcheck (
    $base_directory   = undef,
    $rootkit_files    = undef,
    $rootkit_trojans  = undef,
    $windows_audit    = undef,
    $system_audit     = undef,
    $windows_apps     = undef,
    $windows_malware  = undef,
    $scanall          = undef,
    $frequency        = undef,
    $disabled         = undef,
    $check_dev        = undef,
    $check_files      = undef,
    $check_if         = undef,
    $check_pids       = undef,
    $check_policy     = undef,
    $check_ports      = undef,
    $check_sys        = undef,
    $check_trojans    = undef,
    $check_unixaudit  = undef,
    $check_winapps    = undef,
    $check_winaudit   = undef,
    $check_winmalware = undef
    ) inherits ossec::params {

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_rootcheck":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '65',
      content => template("ossec/rootcheck-options.erb"),
    }
}
