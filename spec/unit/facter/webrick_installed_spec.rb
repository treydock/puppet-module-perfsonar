# frozen_string_literal: true

require 'spec_helper'

describe 'webrick_installed fact' do
  let(:present) do
    <<~OUTPUT

*** LOCAL GEMS ***

webrick (default: 1.6.1)
    OUTPUT
  end

  let(:absent) do
    <<~OUTPUT

*** LOCAL GEMS ***

    OUTPUT
  end

  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  it 'returns true' do
    allow(Facter::Core::Execution).to receive(:execute).with('/opt/puppetlabs/puppet/bin/gem list --local webrick').and_return(present)
    expect(Facter.fact(:webrick_installed).value).to eq(true)
  end

  it 'returns false' do
    allow(Facter::Core::Execution).to receive(:execute).with('/opt/puppetlabs/puppet/bin/gem list --local webrick').and_return(absent)
    expect(Facter.fact(:webrick_installed).value).to eq(false)
  end
end
