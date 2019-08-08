# puppet-module-perfsonar

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/perfsonar.svg)](https://forge.puppetlabs.com/treydock/perfsonar)
[![Build Status](https://travis-ci.org/treydock/puppet-module-perfsonar.png)](https://travis-ci.org/treydock/puppet-module-perfsonar)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with oxidized](#setup)
    * [What perfsonar affects](#what-perfsonar-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oxidized](#beginning-with-oxidized)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - Module reference](#reference)

## Description

This module will manage [perfSONAR](https://docs.perfsonar.net/index.html)

## Setup

### What perfsonar affects

At this time the module only adds the perfSONAR repo, installs packages and manages firewall rules.

### Setup Requirements

For systems with `yum` package manager using Puppet >= 6.0 there is a dependency on [puppetlabs/yum_core](https://forge.puppet.com/puppetlabs/yum_core).

## Usage

To install perfSONAR:

```puppet
include ::perfsonar
```

## Reference

[http://treydock.github.io/puppet-module-perfsonar/](http://treydock.github.io/puppet-module-perfsonar/)
