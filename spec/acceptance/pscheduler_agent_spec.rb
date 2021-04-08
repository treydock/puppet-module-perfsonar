require 'spec_helper_acceptance'

describe 'perfsonar::pscheduler::agent' do
  context 'with pscheduler_agent_config' do
    let(:pp) do
      <<-EOS
      class { 'perfsonar':
        manage_firewall         => false,
        manage_pscheduler_agent => true,
        pscheduler_agent_config => {
          remotes => [{
            url                 => 'https://foo.example.org',
            configure-archives => true,
          }],
        }
      }
      EOS
    end

    it 'runs successfully' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('psconfig-pscheduler-agent') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file('/etc/perfsonar/psconfig/pscheduler-agent.json') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'perfsonar' }
      it { is_expected.to be_grouped_into 'perfsonar' }
      it { is_expected.to be_mode '644' } # serverspec does not like a leading 0
      its(:content) { is_expected.to match %r{https://foo.example.org} }
    end
  end
end
