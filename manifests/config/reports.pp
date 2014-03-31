#
class ossec::config::reports (
    $group,
    $categories,
    $rule,
    $level,
    $location,
    $srcip,
    $user,
    $title,
    $email_to,
    $showlogs
    ) inherits ossec::params {

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::reports is for setting ossec server options only" )
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_reports":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '45',
      content => template("ossec/reports-options.erb"),
    }
}
