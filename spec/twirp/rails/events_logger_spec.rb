# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Twirp::Rails::EventsLogger do
  let(:logger) { spy }

  before do
    allow(described_class).to receive(:logger).and_return(logger)
  end

  describe '.log_before_event' do
    it 'log the message' do 
      described_class.log_before_event({}, {})
      expect(logger).to have_received(:info)
    end
  end

  describe '.log_on_success_event' do
    it 'log the message' do 
      described_class.log_on_success_event({})
      expect(logger).to have_received(:info)
    end
  end

  describe '.log_on_error_event' do
    it 'log the message' do 
      described_class.log_on_error_event({}, {})
      expect(logger).to have_received(:info)
    end
  end

  describe '.log_exception_raised_event' do
    it 'log the message' do 
      described_class.log_exception_raised_event(spy, {})
      expect(logger).to have_received(:error)
    end
  end
end
