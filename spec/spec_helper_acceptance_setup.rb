collection = ENV['BEAKER_PUPPET_COLLECTION'] || 'puppet5'

RSpec.configure do |c|
  c.before :suite do
    if collection == 'puppet6'
      on hosts, puppet('module', 'install', 'puppetlabs-yumrepo_core', '--version', '">= 1.0.1 < 2.0.0"'), acceptable_exit_codes: [0, 1]
    end
  end
end

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
