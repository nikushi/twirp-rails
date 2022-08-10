# frozen_string_literal: true

module Twirp
  module Rails
    class EventsLogger
      def initialize(logger)
        @logger = logger
      end

      def register(service)
        service.before { |*args| log_before_event(*args) }
        service.on_success { |*args| log_on_success_event(*args) }
        service.on_error { |*args| log_on_error_event(*args) }
        service.exception_raised { |*args| log_exception_raised_event(*args) }
      end

      private

      def log_before_event(rack_env, env)
        params = env[:input].to_h
        env[:request_start_time] = Time.now

        @logger.info "Starting handler for twirp request #{env[:input_class]}##{env[:ruby_method]}"
        @logger.info " Parameters: #{params.inspect}" unless params.empty?
      end

      def log_on_success_event(env)
        @logger.info "Completed with success in #{event_duration(env)}ms"
      end

      def log_on_error_event(twerr, env)
        @logger.info "Completed with error in #{event_duration(env)}ms #{twerr}"
      end

      def log_exception_raised_event(e, env)
        @logger.error "[Exception] #{e.class}:#{e.message}\n#{e.backtrace.join("\n")}"
      end

      def event_duration(env)
        request_start_time = env[:request_start_time]
        return -1 unless request_start_time

        ((Time.now - request_start_time) * 1000).to_i
      end
    end
  end
end
