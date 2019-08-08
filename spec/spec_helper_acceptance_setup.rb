collection = ENV['BEAKER_PUPPET_COLLECTION'] || 'puppet5'

RSpec.configure do |c|
  c.before :suite do
    if collection == 'puppet6'
      on hosts, puppet('module', 'install', 'puppetlabs-yumrepo_core', '--version', '">= 1.0.1 < 2.0.0"'), acceptable_exit_codes: [0, 1]
    end
  end
end
