# ossec module for Puppet

## Description

This module manages OSSEC server and client configuration through Puppet

## Requirements

##### Puppet `storeconfigs` must be enabled.

##### Set `client_seed` in params.pp

This should be a randomly generated string of characters, and params.pp should
have permissions set such that only the `puppet` user and read/write the file.
One could use `openssl rand -base64 12` to generate the client_seed.

##### Set `ossec_dir` in params.pp

This is the base directory of your OSSEC installation. The default location for this
puppet module is `/var/lib/ossec` and likely needs to be modified as by default OSSEC
installs into `/var/ossec`.

## Setup

To install ossec as a server or client:
```
node 'ossec' {
    class { "ossec::server" }
}

node 'client' {
    class { "ossec::client": }
}
```

### Configuration

Declaring the `ossec::server` or `ossec::client` class will install ossec, however
it will still need to be configured for your environment, this is managed by
the `ossec::config::*` classes and defined types.

Client Configuration:

The `ossec::config::client` class manages the client configuration. 4 paramaters
are available, `server_ip`, `server_hostname`, `server_port`, and `notify_time`.
Of these either `server_ip` or `server_hostname` are required.

```
class { "ossec::config::client":
    server_ip => '1.1.1.1'
    }
```

Server Configuration:

The `ossec::server` configuration is managed by numerous types, see the
Configuration types below, but at a minimum you'll want to define the
`ossec::config::global` values to setup email notifications.

```
class { "ossec::config::global":
    email_to    => 'ossec@ossec.org',
    smtp_server => 'smtp.ossec.org',
    }
```

#### Configuration types

##### `ossec::server`
Install and configure OSSEC server. The following parameters are available:
`enable_db` = true|false
`enable_debug` = true|false
`enable_agentless` = true|false
`enable_csyslog` = true|false

##### `ossec::client`
Install and configure OSSEC client/agents
 
##### ossec::config::activeres 
 Puppet type: defined type

##### ossec::config::agentless 
Configure agentless options

##### ossec::config::alerts 
Configure alerts

##### ossec::config::client 
Configure the client

##### ossec::config::command 
Configure commands

##### ossec::config::database 
Configure database type and options

##### ossec::config::email
Configure email options

##### ossec::config::global 
Configure global server options

    class { "ossec::config::global": email_to => "systems@ossec.org" }

##### ossec::config::localfile 
Configure local files to monitor

    ossec::config::localfile { "/var/log/messages": }

##### ossec::config::remote 
Configure remote options

##### ossec::config::reports 
Configure reports

##### ossec::config::rootcheck
Configure rootcheck options

##### ossec::config::rules 
Configure rules, `order` is required.

    ossec::config::rules { "pam_rules.xml": order => '2' }

##### ossec::config::syscheck 
Configure syscheck options

    class { "ossec::config::syscheck": alert_new_files => 'yes' }

##### ossec::config::syscheck::dir
Configure syscheck directories to monitor

    ossec::config::syscheck::dir { "/etc": report_changes => 'yes' }
    ossec::config::syscheck::dir { "/bin": }

##### ossec::config::syscheck::ignore
Configure syscheck directories and files to ignore

    ossec::config::syscheck::ignore { "/etc/mtab": }

##### ossec::config::syslog 
Configure syslog options






