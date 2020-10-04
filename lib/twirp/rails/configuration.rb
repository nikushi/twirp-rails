# frozen_string_literal: true

module Twirp
  module Rails
    class Configuration
      attr_reader :handlers_paths

      def initialize
        @handlers_paths = []
      end

      def add_handlers_path(path)
        @handlers_paths << path.to_s
      end
    end
  end
end
