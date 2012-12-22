require "mobile_view/controller_additions"
require "rack/mobile-detect"

module MobileView
  class Engine < ::Rails::Engine
    initializer "mobile_view.insert_middleware" do |app|
      app.config.middleware.use "Rack::MobileDetect"
    end

    initializer "mobile_view.controller_methods" do |app|
      ActiveSupport.on_load(:action_controller) do
        include MobileView::ControllerAdditions
      end
    end
  end
end
