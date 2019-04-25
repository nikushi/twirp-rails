# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Twirp::Rails::Helpers do
  describe '.bind' do
    it 'binds the service with the handler, then it is stored' do
      expect(Twirp::Rails.services.count).to eq 1
    end
  end
end
