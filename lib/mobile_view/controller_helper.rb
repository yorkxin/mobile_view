module MobileView
  module ControllerHelper
    protected
    def mobile?
      request.headers["X_MOBILE_DEVICE"].present?
    end
  end
end