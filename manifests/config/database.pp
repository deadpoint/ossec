#
class ossec::config::database (
    $db_hostname,
    $db_user,
    $db_password,
    $database,
    $db_type
    ) inherits ossec::params {

    if $ossec::config::install_type == "client" {
      fail( "ossec::config::database is for setting ossec server options only" )
    }

    validate_re($db_type, '^(mysql|postgresql)$',
        "Invalid db_type, [$db_type] must be either mysql or postgresql")

    $conf_file = "${ossec::params::conf_file}"

    concat::fragment { "ossec_database":
      ensure  => 'present',
      target  => "$conf_file",
      order   => '08',
      content => template("ossec/database-options.erb"),
    }
}
