# frozen_string_literal: true

module Twirp
  module Rails
    class EventsCallbacks
      def self.register(service)
        service.before do |rack_env, env| 
          env[:request_start_time] = Time.now
          EventsLogger.log_before_event(rack_env, env) if EventsLogger.logger.present?
        end

        service.on_success do |env| 
          register_event_duration(env)
          EventsLogger.log_on_success_event(env) if EventsLogger.logger.present?
        end

        service.on_error do |twerr, env| 
          register_event_duration(env)
          EventsLogger.log_on_error_event(twerr, env) if EventsLogger.logger.present?
        end

        service.exception_raised do |e, env| 
          EventsLogger.log_exception_raised_event(e, env) if EventsLogger.logger.present?
        end
      end

      private_instance_methods

      def self.register_event_duration(env)
        request_start_time = env[:request_start_time]
        return -1 unless request_start_time

        env[:event_duration] = ((Time.now - request_start_time) * 1000).to_i
      end
    end
  end
end
