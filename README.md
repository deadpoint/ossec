# ossec module for Puppet

## Description

This module manages OSSEC server and client configuration through Puppet

## Requirements

* Puppet `storeconfigs` must be enabled.

* Set client_seed in params.pp

This should be a randomly generated string of characters, and params.pp should
have permissions set such that only the `puppet` user and read/write the file.
One could use `openssl rand -base64 12` to generate the client_seed.

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
    email_to    => 'ossec@domain.com',
    smtp_server => 'smtp.domain.com',
    }
```

#### Configuration types
 
* ossec::config::activeres 
  Puppet type: defined type

* ossec::config::agentless 
  Puppet type: class

* ossec::config::alerts 
  Puppet type: class

* ossec::config::client 
  Puppet type: class

* ossec::config::command 
  Puppet Type: defined type

* ossec::config::database 
  Puppet Type: class

* ossec::config::email
  Puppet Type: defined type

* ossec::config::global 
  Puppet Type: class

* ossec::config::localfile 
  Puppet Type: defined type

* ossec::config::remote 
  Puppet Type: class

* ossec::config::reports 
  Puppet Type: class

* ossec::config::rootcheck
  Puppet Type: class

* ossec::config::rules 
  Puppet Type: defined type

* ossec::config::syscheck 
  Puppet Type: class

* ossec::config::syslog 
  Puppet Type: class






