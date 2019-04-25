# frozen_string_literal: true

require 'rails/engine'

module Twirp
  module Rails
    class Engine < ::Rails::Engine
      initializer "twirp.rails.routes" do
        Twirp::Rails::Routes.install!
      end
    end
  end
end
