#
class ossec::config::rootcheck (
    $base_directory,
    $rootkit_files,
    $rootkit_trojans,
    $windows_audit,
    $system_audit,
    $windows_apps,
    $windows_malware,
    $scanall,
    $frequency,
    $disabled,
    $check_dev,
    $check_files,
    $check_if,
    $check_pids,
    $check_policy,
    $check_ports,
    $check_sys,
    $check_trojans,
    $check_unixaudit,
    $check_winapps,
    $check_winaudit,
    $check_winmalware
    ) inherits ossec::params {

    include ossec::config

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_rootcheck":
        target  => "$content",
        order   => '65',
        content => template("ossec/rootcheck-options.erb"),
    }
}
