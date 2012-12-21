module MobileView
  module ControllerHelper
    protected
    def mobile_device?
      request.headers["X_MOBILE_DEVICE"].present?
    end
  end
end