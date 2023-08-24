# puppet-module-perfsonar

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/perfsonar.svg)](https://forge.puppetlabs.com/treydock/perfsonar)
[![CI Status](https://github.com/treydock/puppet-module-perfsonar/workflows/CI/badge.svg?branch=master)](https://github.com/treydock/puppet-module-perfsonar/actions?query=workflow%3ACI)


#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with perfsonar](#setup)
    * [What perfsonar affects](#what-perfsonar-affects)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - Module reference](#reference)

## Description

This module will manage [perfSONAR](https://docs.perfsonar.net/index.html)

## Setup

### What perfsonar affects

At this time the module only adds the perfSONAR repo, installs packages and manages firewall rules.

## Usage

To install perfSONAR:

```puppet
include perfsonar
```

Set the web user's admin password and remove file that adds a prompt to root logins:

```puppet
class { 'perfsonar':
  web_admin_password => 'changeme',
  remove_root_prompt => true,
}
```

**NOTE: On Puppet 8 the process to add the web admin password is not idempotent. Applying the web admin password on Puppet 8 requires 2 Puppet runs**

### Managing pscheduler-agent

One or more `pscheduler-agent` remotes may be configured.

(Hiera Example)

```yaml
perfsonar::manage_pscheduler_agent: true
perfsonar::pscheduler_agent_config:
  remotes:
    - url: "https://foo.example.org/psconfig/bar.json"
      configure-archives: true
```

### Disabling perfsonar-lsregistrationdaemon

The `perfsonar-lsregistrationdaemon` daemon is responsible for registering the
perfsonar instance in the global registry.

(Hiera Example)

```yaml
perfsonar::manage_lsregistrationdaemon: true
perfsonar::lsregistrationdaemon_ensure: 'stopped'
perfsonar::lsregistrationdaemon_enable: false
```

## Reference

[http://treydock.github.io/puppet-module-perfsonar/](http://treydock.github.io/puppet-module-perfsonar/)
