# frozen_string_literal: true

# webrick_installed.rb

Facter.add(:webrick_installed) do
  confine kernel: 'Linux'

  setcode do
    installed = false
    match = nil
    out = Facter::Core::Execution.execute('/opt/puppetlabs/puppet/bin/gem list --local webrick')
    match = out.match(%r{^webrick }) unless out.nil?
    if match
      installed = true
    end
    installed
  end
end
