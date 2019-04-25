# frozen_string_literal: true

module Twirp
  module Rails
    class Configuration
      attr_reader :handlers_path

      def initialize
        @handlers_path = nil
      end

      def handlers_path=(v)
        @handlers_path = v.to_s
      end
    end
  end
end
