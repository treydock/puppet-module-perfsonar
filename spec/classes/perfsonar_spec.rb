require 'spec_helper'

describe 'perfsonar' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      context 'when with_ipv6 => true' do
        let(:params) { { with_ipv6: true } }

        it { is_expected.to compile }
      end
    end
  end
end
