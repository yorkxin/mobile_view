require "rack/mobile-detect"

module MobileView
  class Engine < ::Rails::Engine
    initializer "mobile_view.insert_middleware" do |app|
      app.config.middleware.use "Rack::MobileDetect"
    end

  end
end
