# PRIVATE CLASS: do not use directly
class ossec::config (
    $install_type
    ) {

    include concat::setup
    include ossec::params

    validate_re($install_type, '^(client|server)$',
        "Invalid install_type, [$install_type] must be client or server")

    $content = "${ossec::params::conf_file}"

    concat { "$content":
        owner       => 'root',
        group       => $ossec::params::group,
        mode        => '0644',
        require     => Package['ossec'],
        notify      => Class['Ossec::Service'],
    }
    # header/footer for all install types
    concat::fragment { "ossec_header":
        target  => "$content",
        order   => '01',
        content => template("ossec/config-header.erb"),
    }
    concat::fragment { "ossec_footer":
        target  => "$content",
        order   => '9999',
        content => template("ossec/config-footer.erb"), 
    }
    # only servers get these
    if $install_type == "server" {
        concat::fragment { "ossec_rules_begin":
            target  => "$content",
            order   => '2000',
            content => template("ossec/rules-begin.erb"),
        }
        concat::fragment { "ossec_rules_end":
            target  => "$content",
            order   => '2999',
            content => template("ossec/rules-end.erb"),
        }
    }
}
