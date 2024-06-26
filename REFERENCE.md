# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`perfsonar`](#perfsonar): Manage perfSONAR

#### Private Classes

* `perfsonar::config`: Manage perfSONAR configs
* `perfsonar::firewall`: Manage perfSONAR firewall rules
* `perfsonar::install`: Manage perfsonar packages
* `perfsonar::lsregistrationdaemon`: Manage perfsonar-lsregistrationdaemon service
* `perfsonar::pscheduler::agent`: Manage pschedular-agent service
* `perfsonar::repo`: Manage perfsonar repo

## Classes

### <a name="perfsonar"></a>`perfsonar`

Manage perfSONAR

#### Examples

##### 

```puppet
include perfsonar
```

#### Parameters

The following parameters are available in the `perfsonar` class:

* [`manage_repo`](#-perfsonar--manage_repo)
* [`manage_epel`](#-perfsonar--manage_epel)
* [`release_url`](#-perfsonar--release_url)
* [`bundle`](#-perfsonar--bundle)
* [`optional_packages`](#-perfsonar--optional_packages)
* [`manage_firewall`](#-perfsonar--manage_firewall)
* [`with_ipv6`](#-perfsonar--with_ipv6)
* [`web_admin_username`](#-perfsonar--web_admin_username)
* [`web_admin_password`](#-perfsonar--web_admin_password)
* [`remove_root_prompt`](#-perfsonar--remove_root_prompt)
* [`apache_group`](#-perfsonar--apache_group)
* [`manage_apache`](#-perfsonar--manage_apache)
* [`ssl_cert`](#-perfsonar--ssl_cert)
* [`ssl_key`](#-perfsonar--ssl_key)
* [`ssl_chain_file`](#-perfsonar--ssl_chain_file)
* [`apache_ssl_conf`](#-perfsonar--apache_ssl_conf)
* [`apache_service`](#-perfsonar--apache_service)
* [`primary_interface`](#-perfsonar--primary_interface)
* [`manage_pscheduler_agent`](#-perfsonar--manage_pscheduler_agent)
* [`pscheduler_agent_config`](#-perfsonar--pscheduler_agent_config)
* [`manage_lsregistrationdaemon`](#-perfsonar--manage_lsregistrationdaemon)
* [`lsregistrationdaemon_ensure`](#-perfsonar--lsregistrationdaemon_ensure)
* [`lsregistrationdaemon_enable`](#-perfsonar--lsregistrationdaemon_enable)

##### <a name="-perfsonar--manage_repo"></a>`manage_repo`

Data type: `Boolean`

Boolean that determines if perfSONAR repos will be managed.

Default value: `true`

##### <a name="-perfsonar--manage_epel"></a>`manage_epel`

Data type: `Boolean`

Boolean that determines if EPEL repo is managed.

Default value: `true`

##### <a name="-perfsonar--release_url"></a>`release_url`

Data type: `Variant[Stdlib::HTTPUrl,Stdlib::HTTPSUrl]`

Release URL for adding GPG key

Default value: `"https://software.internet2.edu/rpms/el${facts['os']['release']['major']}/x86_64/latest/packages/perfsonar-repo-0.11-1.noarch.rpm"`

##### <a name="-perfsonar--bundle"></a>`bundle`

Data type: `Enum['perfsonar-tools','perfsonar-testpoint','perfsonar-core','perfsonar-centralmanagement','perfsonar-toolkit']`

The perfSONAR bundle package to install

Default value: `'perfsonar-toolkit'`

##### <a name="-perfsonar--optional_packages"></a>`optional_packages`

Data type: `Array`

Array of optional packages to install

Default value: `[]`

##### <a name="-perfsonar--manage_firewall"></a>`manage_firewall`

Data type: `Boolean`

Boolean that determines if firewall rules are managed.

Default value: `true`

##### <a name="-perfsonar--with_ipv6"></a>`with_ipv6`

Data type: `Boolean`

Boolean that determines if IPv6 support should be enabled

Default value: `false`

##### <a name="-perfsonar--web_admin_username"></a>`web_admin_username`

Data type: `String`

User name used to log into perfSONAR web interface

Default value: `'admin'`

##### <a name="-perfsonar--web_admin_password"></a>`web_admin_password`

Data type: `Optional[String]`

Password for perfSONAR web login

Default value: `undef`

##### <a name="-perfsonar--remove_root_prompt"></a>`remove_root_prompt`

Data type: `Boolean`

Boolean that determines if file should be removed that
provides a prompt for setup when root logs in.

Default value: `false`

##### <a name="-perfsonar--apache_group"></a>`apache_group`

Data type: `String`

Group used by Apache

Default value: `'apache'`

##### <a name="-perfsonar--manage_apache"></a>`manage_apache`

Data type: `Boolean`

Boolean that sets if Apache should be managed

Default value: `false`

##### <a name="-perfsonar--ssl_cert"></a>`ssl_cert`

Data type: `Stdlib::Absolutepath`

The path to Apache SSL certificate

Default value: `'/etc/pki/tls/certs/localhost.crt'`

##### <a name="-perfsonar--ssl_key"></a>`ssl_key`

Data type: `Stdlib::Absolutepath`

The path to Apache SSL private key

Default value: `'/etc/pki/tls/private/localhost.key'`

##### <a name="-perfsonar--ssl_chain_file"></a>`ssl_chain_file`

Data type: `Optional[Stdlib::Absolutepath]`

The path to Apache SSL chain file

Default value: `undef`

##### <a name="-perfsonar--apache_ssl_conf"></a>`apache_ssl_conf`

Data type: `Stdlib::Absolutepath`

The path to Apache SSL configuration file

Default value: `'/etc/httpd/conf.d/ssl.conf'`

##### <a name="-perfsonar--apache_service"></a>`apache_service`

Data type: `String`

The Apache service name

Default value: `'httpd'`

##### <a name="-perfsonar--primary_interface"></a>`primary_interface`

Data type: `Optional[String]`

The primary interface of host

Default value: `$facts.dig('networking','primary')`

##### <a name="-perfsonar--manage_pscheduler_agent"></a>`manage_pscheduler_agent`

Data type: `Boolean`

Weather or not the pscheduler-agent daemon should be managed

Default value: `false`

##### <a name="-perfsonar--pscheduler_agent_config"></a>`pscheduler_agent_config`

Data type: `Optional[Hash]`

Configuration to convert to json and write to pscheduler-agent.json

Default value: `undef`

##### <a name="-perfsonar--manage_lsregistrationdaemon"></a>`manage_lsregistrationdaemon`

Data type: `Boolean`

Weather or not the perfsonar-lsregistrationdaemon daemon should be managed

Default value: `false`

##### <a name="-perfsonar--lsregistrationdaemon_ensure"></a>`lsregistrationdaemon_ensure`

Data type: `Stdlib::Ensure::Service`

perfsonar-lsregistrationdaemon service ensure

Default value: `'running'`

##### <a name="-perfsonar--lsregistrationdaemon_enable"></a>`lsregistrationdaemon_enable`

Data type: `Boolean`

perfsonar-lsregistrationdaemon service enable

Default value: `true`

