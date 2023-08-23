# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'perfsonar::lsregistrationdaemon' do
  context 'with manage_lsregistrationdaemon' do
    let(:pp) do
      <<-PP
      class { 'perfsonar':
        manage_firewall             => false,
        manage_lsregistrationdaemon => true,
        lsregistrationdaemon_ensure => 'stopped',
        lsregistrationdaemon_enable => false,
      }
      PP
    end

    it 'runs successfully' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('perfsonar-lsregistrationdaemon') do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end
  end
end
