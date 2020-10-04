# frozen_string_literal: true

RSpec.describe Twirp::Rails::Configuration do
  describe '#add_handlers_path' do
    subject { config.add_handlers_path(path) }

    let(:config) { described_class.new }
    let(:path) { 'app/controllers/rpc' }

    it { is_expected.to eq ['app/controllers/rpc'] }
  end
end
