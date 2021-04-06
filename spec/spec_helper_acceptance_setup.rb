hiera_yaml = <<-EOS
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
EOS
debian_yaml = <<-EOS
---
perfsonar::bundle: perfsonar-testpoint
EOS

create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
on hosts, 'mkdir -p /etc/puppetlabs/puppet/data/os'
create_remote_file(hosts, '/etc/puppetlabs/puppet/data/os/Debian.yaml', debian_yaml)
