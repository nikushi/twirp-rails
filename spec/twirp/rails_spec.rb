# frozen_string_literal: true

RSpec.describe Twirp::Rails do
  describe '.services' do
    subject { described_class.services }

    it { is_expected.to be_a Array }
  end
end
