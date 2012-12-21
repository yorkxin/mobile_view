require "mobile_view/controller_helper"
require "rack/mobile-detect"

module MobileView
  class Engine < ::Rails::Engine
    initializer "mobile_view.insert_middleware" do |app|
      app.config.middleware.use "Rack::MobileDetect"
    end

    initializer "mobile_view.controller_methods" do |app|
      ActionController::Base.send :include, MobileView::ControllerHelper

      # make mobile_device? method a view helper too
      ActionController::Base.send :helper_method, :mobile_device?

      # find mobile view templates first, if mobile device is detected.
      ActionController::Base.send :before_filter, Proc.new {
        prepend_view_path(MobileView.resolver) if mobile_device?
      }
    end
  end
end
