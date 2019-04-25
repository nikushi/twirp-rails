# frozen_string_literal: true

require "twirp/rails/configuration"
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
    end
  end
end
