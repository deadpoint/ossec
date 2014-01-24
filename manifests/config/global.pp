#
class ossec::config::global (
    $email_notification     = $ossec::params::email_notification,
    $email_to               = $ossec::params::email_to,
    $email_from             = $ossec::params::email_from,
    $email_maxperhour       = $ossec::params::email_maxperhour,
    $smtp_server            = $ossec::params::smtp_server,
    $status                 = $ossec::params::status,
    $logall                 = $ossec::params::logall,
    $memory_size            = $ossec::params::memory_size,
    $white_list             = $ossec::params::white_list,
    $host_infomation        = $ossec::params::host_infomation,
    ) inherits ossec::params {

    #include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::global is for setting ossec server options only" )
    }

    $content = "${ossec::params::conf_dir}/temp.conf"

    concat::fragment { "ossec_global":
        target  => "$content",
        order   => '05',
        content => template("ossec/global-options.erb"),
    }
}
