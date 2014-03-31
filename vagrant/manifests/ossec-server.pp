# Firewall rule to allow ossec port
firewall { '100 accept UDP 1514':
  port   => '1514',
  proto  => 'udp',
  action => 'accept',
}

# Clientkey mock resource - would typically be pulled from exported resource
ossec::clientkey { "ossec_key_ossec-client.acme.com_server":
  client_id   => '007f0100',
  client_name => 'ossec-client.acme.com',
  client_ip   => '192.168.50.20',
}

# Rules config
ossec::config::rules { 'sshd_rules.xml':        order => '1' }
ossec::config::rules { 'telnetd_rules.xml':     order => '2' }
ossec::config::rules { 'syslog_rules.xml':      order => '3' }
ossec::config::rules { 'arpwatch_rules.xml':    order => '4' }
ossec::config::rules { 'symantec-av_rules.xml': order => '5' }
ossec::config::rules { 'named_rules.xml':       order => '6' }
ossec::config::rules { 'apache_rules.xml':      order => '7' }
ossec::config::rules { 'nginx_rules.xml':       order => '8' }
ossec::config::rules { 'spamd_rules.xml':       order => '9' }
ossec::config::rules { 'ossec_rules.xml':       order => '10' }
ossec::config::rules { 'attack_rules.xml':      order => '11' }
ossec::config::rules { 'local_rules.xml':       order => '12' }

# Syscheck config
include ossec::config::syscheck

ossec::config::syscheck::dir { '/etc,/usr/bin,/usr/sbin': }
ossec::config::syscheck::dir { '/bin,/sbin': }

ossec::config::syscheck::ignore { '/etc/mtab': }
ossec::config::syscheck::ignore { '/etc/hosts.deny': }
ossec::config::syscheck::ignore { '/etc/mail/statistics': }
ossec::config::syscheck::ignore { '/etc/random-seed': }
ossec::config::syscheck::ignore { '/etc/adjtime': }
ossec::config::syscheck::ignore { '/etc/httpd/logs': }

# Rootcheck config
class { 'ossec::config::rootcheck':
  rootkit_files   => '/var/ossec/etc/shared/rootkit_files.txt',
  rootkit_trojans => '/var/ossec/etc/shared/rootkit_trojans.txt',
}

# Command Config
ossec::config::command { "host-deny":
  executable      => 'host-deny.sh',
  expect          => 'srcip',
  timeout_allowed => 'yes',
}
ossec::config::command { "firewall-drop":
  executable      => 'firewall-drop.sh',
  expect          => 'srcip',
  timeout_allowed => 'yes',
}
ossec::config::command { "disable-account":
  executable      => 'disable-account.sh',
  expect          => 'user',
  timeout_allowed => 'yes',
}

# Active Response Config
ossec::config::activeres { 'host-deny':
  command  => 'host-deny',
  location => 'local',
  level    => '6',
  timeout  => '600',
}

ossec::config::activeres { 'firewall-drop':
  command  => 'firewall-drop',
  location => 'local',
  level    => '6',
  timeout  => '600',
}

# Localfile Config
ossec::config::localfile { '/var/log/messages': }
ossec::config::localfile { '/var/log/authlog': }
ossec::config::localfile { '/var/log/secure': }
ossec::config::localfile { '/var/log/xferlog': }
ossec::config::localfile { '/var/log/maillog': }
ossec::config::localfile { '/var/log/access_log':
  log_format => 'apache',
}
ossec::config::localfile { '/var/log/error_log':
  log_format => 'apache',
}

include ossec::server

