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

      # A module to modify the output of the controller part on `rails routes`
      module Inspectable
        REMOVABLE_SUFFIX_RE = /(_handler|_controller)\z/

        def inspect
          instance_variable_get(:@handler).class.name.underscore.sub(REMOVABLE_SUFFIX_RE, '')
        end
      end

      # A null hanlder to cause a bad_route error by unexpected rpc call, instead of raising a routing error by Rails.
      class CatchAllHandler; end

      def self.install!
        ActionDispatch::Routing::Mapper.send :include, Twirp::Rails::Routes::Helper
      end

      attr_reader :routes

      def initialize(routes, services)
        @routes = routes
        @services = services
      end

      def generate_routes!(options)
        routes.scope options[:scope] || 'twirp' do
          @services.each do |service, context|
            next unless in_context?(options[:context], context)

            service.extend Inspectable
            service.class.rpcs.values.each do |h|
              rpc_method = h[:rpc_method]
              path = service.full_name + '/' + rpc_method.to_s
              @routes.match path, to: service, format: false, via: :all
            end
          end

          # Set catch-all route
          null_service = ::Twirp::Service.new(CatchAllHandler.new)
          null_service.extend Inspectable
          routes.mount null_service, at: '/'
        end
      end

      def in_context?(option_context, bind_context)
        return true if option_context.nil?
        return true if bind_context.nil?

        option_context == bind_context
      end
    end
  end
end
