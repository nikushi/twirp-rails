# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Twirp::Rails::EventsCallbacks do
  describe '#register' do
    let(:service) { Twirp::Service.new(Object.new) }
    it 'register callback for before event' do
      expect { described_class.register(service) }.to change { service.instance_variable_get(:@before).length }.by(1)
    end

    it 'register callback for on_success event' do
      expect { described_class.register(service) }.to change { service.instance_variable_get(:@on_success).length }.by(1)
    end

    it 'register callback for on_error event' do
      expect { described_class.register(service) }.to change { service.instance_variable_get(:@on_error).length }.by(1)
    end

    it 'register callback for exception_raised event' do
      expect { described_class.register(service) }.to change { service.instance_variable_get(:@exception_raised).length }.by(1)
    end
  end
end
