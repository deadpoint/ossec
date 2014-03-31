#
define ossec::config::syscheck::dir (
    $realtime           = undef,
    $report_changes     = undef,
    $check_all          = 'yes',
    $check_sum          = undef,
    $check_sha1sum      = undef,
    $check_md5sum       = undef,
    $check_size         = undef,
    $check_owner        = undef,
    $check_group        = undef,
    $check_perm         = undef,
    $restrict           = undef
    ) {
    #validate_re($realtime, '^(yes|no)', "Invalid $realtime, [$realtime] must be yes or no")
    #validate_re($report_changes, '^(yes|no)', "Invalid $report_changes, [$report_changes] must be yes or no")
    #validate_re($check_all, '^(yes|no)', "Invalid $check_all, [$check_all] must be yes or no")
    #validate_re($check_sum, '^(yes|no)', "Invalid $check_sum, [$check_sum] must be yes or no")
    #validate_re($check_sha1sum, '^(yes|no)', "Invalid $check_sha1sum, [$check_sha1sum] must be yes or no")
    #validate_re($check_md5sum, '^(yes|no)', "Invalid $check_md5sum, [$check_md5sum] must be yes or no")
    #validate_re($check_size, '^(yes|no)', "Invalid $check_size, [$check_size] must be yes or no")
    #validate_re($check_owner, '^(yes|no)', "Invalid $check_owner, [$check_owner] must be yes or no")
    #validate_re($check_group, '^(yes|no)', "Invalid $check_group, [$check_group] must be yes or no")
    #validate_re($check_perm, '^(yes|no)', "Invalid $check_perm, [$check_perm] must be yes or no")
    #validate_re($restrict, '^(yes|no)', "Invalid $restrict, [$restrict] must be yes or no")

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "syscheck_dir_${name}":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '13',
      content => template("ossec/syscheck-dir.erb"),
    }
}
