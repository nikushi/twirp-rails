# frozen_string_literal: true

require 'rails/engine'

module Twirp
  module Rails
    class Engine < ::Rails::Engine
      initializer "twirp.rails.routes" do
        Twirp::Rails.load_handlers
        Twirp::Rails.register_callbacks
        Twirp::Rails::Routes.install!
      end
    end
  end
end
