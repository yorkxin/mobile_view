module MobileView
  module ControllerHelper
    extend ActiveSupport::Concern

    included do
      # make mobile? method a view helper too
      helper_method :mobile?

      # find mobile view templates first, if mobile device is detected.
      before_filter do
        prepend_view_path(MobileView.resolver) if mobile?
      end
    end

    protected
    def mobile?
      cookies[:mobile].present? || request.headers["X_MOBILE_DEVICE"].present?
    end
  end
end
