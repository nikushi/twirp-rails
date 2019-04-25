# frozen_string_literal: true

RSpec.describe Twirp::Rails::Configuration do
  describe '#handlers_path' do
    subject { config.handlers_path }

    let(:config) { described_class.new }

    before { config.handlers_path = 'app/controllers/rpc' }
    it { is_expected.to eq 'app/controllers/rpc' }
  end
end
