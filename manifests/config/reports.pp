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

    include ossec::config

    if $ossec::config::install_type == "client" {
       fail( "ossec::config::reports is for setting ossec server options only" )
    }

    $content = "${ossec::params::conf_file}"

    concat::fragment { "ossec_reports":
        target  => "$content",
        order   => '45',
        content => template("ossec/reports-options.erb"),
    }
}
