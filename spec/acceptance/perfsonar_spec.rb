# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'perfsonar class:' do
  context 'with default parameters' do
    it 'runs successfully' do
      pp = <<-PP
      class { 'perfsonar':
        manage_firewall    => false,
      }
      PP

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'with changes' do
    it 'runs successfully' do
      pp = <<-PP
      class { 'perfsonar':
        manage_firewall    => false,
        web_admin_password => 'foobar',
        remove_root_prompt => true,
        manage_apache      => true,
      }
      PP

      apply_manifest(pp, catch_failures: true)
      # TODO: web_admin_password is not idempotent on Puppet 8
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
