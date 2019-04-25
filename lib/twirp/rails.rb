# frozen_string_literal: true

require "twirp/rails/configuration"
require "twirp/rails/helpers"
require "twirp/rails/routes"
require "twirp/rails/engine"
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
    end
  end
end
