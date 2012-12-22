module MobileView
  module ControllerHelper
    protected
    def mobile?
      cookies[:mobile].present? || request.headers["X_MOBILE_DEVICE"].present?
    end
  end
end