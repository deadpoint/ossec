#
class ossec::config::global (
    $email_notification     = $ossec::params::email_notification,
    $email_to               = $ossec::params::email_to,
    $email_from             = $ossec::params::email_from,
    $email_maxperhour       = $ossec::params::email_maxperhour,
    $smtp_server            = $ossec::params::smtp_server,
    $stats                 = $ossec::params::status,
    $logall                 = $ossec::params::logall,
    $memory_size            = $ossec::params::memory_size,
    $white_list             = $ossec::params::white_list,
    $host_information        = $ossec::params::host_information,
    ) inherits ossec::params {

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::global is for setting ossec server options only" )
    }

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_global":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '05',
      content => template("ossec/global-options.erb"),
    }
}
