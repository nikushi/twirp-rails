# frozen_string_literal: true

require "twirp/rails/configuration"
require "twirp/rails/helpers"
require "twirp/rails/routes"
require "twirp/rails/engine"
require "twirp/rails/events_callbacks"
require "twirp/rails/events_logger"
require "twirp/rails/version"

module Twirp
  module Rails
    class << self
      def configuration(&block)
        @configuration ||= Configuration.new
        yield @configuration if block_given?
        @configuration
      end
      attr_writer :configuration

      # A store to register rack apps, which are the instantiated services.
      # @return [Array<Twirp::Service>]
      def services
        @services ||= []
      end

      def load_handlers
        Dir[File.join(configuration.handlers_path.to_s, '**', '*.rb')].each { |f| require f }
      end

      def register_callbacks
        # as for now, the only callbacks are for logging, we can skip it if logger was not set
        return if Twirp::Rails::EventsLogger.logger.nil?

        Twirp::Rails.services.each { |s| Twirp::Rails::EventsCallbacks.register(s) }
      end
    end
  end
end
