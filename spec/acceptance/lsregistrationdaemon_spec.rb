require 'spec_helper_acceptance'

describe 'perfsonar::lsregistrationdaemon' do
  context 'with manage_lsregistrationdaemon' do
    let(:pp) do
      <<-EOS
      class { 'perfsonar':
        manage_firewall             => false,
        manage_lsregistrationdaemon => true,
        lsregistrationdaemon_ensure => 'stopped',
        lsregistrationdaemon_enable => false,
      }
      EOS
    end

    it_behaves_like 'an idempotent resource'

    describe service('perfsonar-lsregistrationdaemon') do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end
  end
end
