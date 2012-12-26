require 'mobile_view/forced_switching'

module MobileView
  module ControllerAdditions
    extend ActiveSupport::Concern

    include MobileView::ForcedSwitching::ControllerAdditions

    included do
      # make mobile? method a view helper too
      helper_method :mobile?

      # find mobile view templates first, if mobile device is detected.
      before_filter do
        prepend_view_path(MobileView.resolver) if mobile?
      end
    end

    protected
    # Returns <tt>true</tt> if +MobileView+ uses mobile version of view templates,
    # <tt>false</tt> otherwise.
    def mobile?
      forced_mobile? || request.headers["X_MOBILE_DEVICE"].present?
    end
  end
end
