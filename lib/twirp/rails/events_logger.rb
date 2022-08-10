# frozen_string_literal: true
module Twirp
  module Rails
    class EventsLogger
      def self.logger
        Twirp::Rails.configuration.logger
      end

      def self.log_before_event(rack_env, env)
        params = env[:input].to_h
        env[:request_start_time] = Time.now

        logger.info "Starting handler for twirp request #{env[:input_class]}##{env[:ruby_method]}"
        logger.info " Parameters: #{params.inspect}" unless params.empty?
      end

      def self.log_on_success_event(env)
        logger.info "Completed with success in #{env[:event_duration]}ms"
      end

      def self.log_on_error_event(twerr, env)
        logger.info "Completed with error in #{env[:event_duration]}ms #{twerr}"
      end

      def self.log_exception_raised_event(e, env)
        logger.error "[Exception] #{e.class}:#{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
  end
end
