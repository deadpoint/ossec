# Class: ossec::params
#
# This class manages ossec parameters, do not call it directly
#
#
class ossec::params {
    $service_name           = 'ossec-hids'
    $client_package_name    = 'ossec-hids-client'
    $server_package_name    = 'ossec-hids-server'
    $user                   = 'ossec'
    $group                  = 'ossec'
    $ossec_dir              = '/var/ossec'
    $conf_dir               = "${ossec_dir}/etc"
    $conf_file              = "${conf_dir}/ossec.conf"
    $client_keys            = "${conf_dir}/client.keys"
    $source                 = ''
    $source_dir             = ''
    $source_dir_purge       = false
    $template               = ''
    $client_seed            = 'YlusJIC4UBSaIIvu'
    $enable_db              = false
    $enable_debug           = false
    $enable_agentless       = false
    $enable_csyslog         = false
    $plist_file             = "${ossec_dir}/bin/.process_list"
    # http://www.ossec.net/doc/syntax/head_ossec_config.client.html
    $server_ip              = '192.168.50.10'
    $server_hostname        = undef
    $server_port            = undef
    $notify_time            = undef
    # http://www.ossec.net/doc/syntax/head_ossec_config.global.html
    $email_notification     = "yes"
    $email_to               = 'devops@acme.com'
    $email_from             = 'devops@acme.com'
    $email_maxperhour       = undef
    $smtp_server            = '192.168.50.10'
    $status                 = undef
    $logall                 = undef
    $memory_size            = undef
    $white_list             = [ '127.0.0.1', '192.168.50.10' ]
    $host_information        = undef
    # http://www.ossec.net/doc/syntax/head_ossec_config.active-response.html
    $active_response        = true
    # http://www.ossec.net/doc/syntax/head_ossec_config.syscheck.html
    $frequency              = 21600
    $directories            = undef
    $ignore                 = undef
    $scan_time              = undef
    $scan_day               = undef
    $auto_ignore            = undef
    $alert_new_files        = undef
    $scan_on_start          = undef
    $windows_registry       = undef
    $registry_ignore        = undef
    $prefilter_cmd          = undef
    # http://www.ossec.net/doc/syntax/head_ossec_config.localfile.html
    $location               = undef
    $log_format             = "syslog"
    $command                = undef
    $ossec_alias            = undef
    $check_diff             = undef
    # http://www.ossec.net/doc/syntax/head_ossec_config.remote.html
    $connection             = "secure"
    $port                   = undef
    $protocol               = undef
    $allowed_ips            = undef
    $deny_ips               = undef
    $local_ips              = undef
}
