# frozen_string_literal: true

module Twirp
  module Rails
    module Helpers
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        def bind(service_klass)
          Twirp::Rails.services << service_klass.new(new)
        end
      end
    end
  end
end
