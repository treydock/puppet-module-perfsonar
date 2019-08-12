require 'spec_helper_acceptance'

describe 'perfsonar class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'perfsonar':
        manage_firewall    => false,
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'changes' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'perfsonar':
        manage_firewall    => false,
        web_admin_password => 'foobar',
        remove_root_prompt => true,
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
