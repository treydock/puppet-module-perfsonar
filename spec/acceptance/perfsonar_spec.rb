require 'spec_helper_acceptance'

describe 'perfsonar class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'firewall':
        ensure_v6 => 'stopped',
      }
      class { 'perfsonar': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
