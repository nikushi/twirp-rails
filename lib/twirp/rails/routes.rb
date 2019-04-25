# frozen_string_literal: true

module Twirp
  module Rails
    class Routes # :nodoc:
      module Helper
        def use_twirp(options = {})
          services = Twirp::Rails.services
          Twirp::Rails::Routes.new(self, services).generate_routes!(options)
        end
      end

      def self.install!
        ActionDispatch::Routing::Mapper.send :include, Twirp::Rails::Routes::Helper
      end

      attr_reader :routes

      def initialize(routes, services)
        @routes = routes
        @services = services
      end

      def generate_routes!(options)
        routes.scope options[:scope] || 'twirp', as: 'twirp' do
          @services.each do |service|
            @routes.match service.full_name, to: service, via: :post
          end
        end
      end
    end
  end
end
