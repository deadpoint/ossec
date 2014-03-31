# PRIVATE CLASS: do not use directly
class ossec::config (
    $install_type
    ) inherits ossec::params {

    include concat::setup

    validate_re($install_type, '^(client|server)$',
        "Invalid install_type, [$install_type], the value must be client or server")

    yumrepo { 'atomic':
      name       => 'atomic',
      descr      => 'CentOS / Red Hat Enterprise Linux $releasever - atomicrocketturtle.com',
      mirrorlist => 'http://updates.atomicorp.com/channels/mirrorlist/atomic/centos-$releasever-$basearch',
      enabled    => '1',
      priority   => '1',
      protect    => '0',
      gpgcheck   => '1',
      gpgkey     => 'file:////etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt',
      before     => Package["ossec"],
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => 'puppet:///modules/ossec/RPM-GPG-KEY.art.txt',
      before => Yumrepo["atomic"],
    }

    exec { 'import-gpg-key-ossec':
      command   => '/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt',
      unless    => '/bin/rpm -q gpg-pubkey-`(/usr/bin/gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt) | /bin/cut --characters=12-19 | /usr/bin/tr [A-Z] [a-z]`',
      logoutput => 'on_failure',
      require   => File['/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt'],
      before    => Yumrepo['atomic'],
    }

    $conf_file = "${ossec::params::conf_file}"

    concat { "$conf_file":
        owner       => 'root',
        group       => $ossec::params::group,
        mode        => '0644',
        require     => Package['ossec'],
        notify      => Class['Ossec::Service'],
    }
    # header/footer for all install types
    concat::fragment { "ossec_header":
        target  => "$conf_file",
        order   => '01',
        content => template("ossec/config-header.erb"),
    }
    concat::fragment { "ossec_footer":
        target  => "$conf_file",
        order   => '9999',
        content => template("ossec/config-footer.erb"),
    }
    # only servers get these
    if $install_type == "server" {
        concat::fragment { "ossec_rules_begin":
            target  => "$conf_file",
            order   => '2000',
            content => template("ossec/rules-begin.erb"),
        }
        concat::fragment { "ossec_rules_end":
            target  => "$conf_file",
            order   => '2999',
            content => template("ossec/rules-end.erb"),
        }
    }
}
