# frozen_string_literal: true

hiera_yaml = <<-HIERA
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: 'os family'
    path: "os/%{facts.os.family}.yaml"
  - name: "Common"
    path: "common.yaml"
HIERA
debian_yaml = <<-HIERA
---
perfsonar::bundle: perfsonar-testpoint
HIERA

create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
on hosts, 'mkdir -p /etc/puppetlabs/puppet/data/os'
create_remote_file(hosts, '/etc/puppetlabs/puppet/data/os/Debian.yaml', debian_yaml)
