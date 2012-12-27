module MobileView
  module ForcedSwitching
    # The name of cookie which remembers forced mobile view switching.
    COOKIE_NAME = "mobile"

    # Value of the cookie to represent "forced to mobile view".
    FORCE_MOBILE_VALUE = "1"

    # Value of the cookie to represent "forced to non-mobile view".
    FORCE_NON_MOBILE_VALUE = "0"

    # These controller additions are helpers that you can use
    # in your controller to test if currently it is forcely (manually) switched to mobile 
    # version, or non-mobile version.
    #
    # By force-switching to either version, MobileView will take it at the top
    # precedence, and ignore the ascending methods (e.g. by User-Agent).
    #
    # Force-switching should happen before {MobileView::ControllerAdditions::ClassMethods#has_mobile_view has_mobile_view}
    # is invoked. See {MobileView::ControllerAdditions::ClassMethods#has_mobile_view has_mobile_view}'s example.
    #
    # They will be automatically included into the controller
    # that includes {MobileView::ControllerAdditions}. You don't need to
    # <tt>include</tt> this module manually.
    #
    # TODO: Unit Testing
    #
    # == Examples
    #
    # === Use as before filters
    #
    #   class AppliactionController < ActionController::Base
    #     before_filter :force_mobile!, :if => :ie6?
    #     before_filter :force_non_mobile!, :if => :ipad?
    #     has_mobile_view
    #   end
    #
    # === Manual Mobile Switching
    #
    # A user can manually switch to mobile version or non-mobile version by specifying `_mobile_view` parameter.
    #
    # For example:
    #
    # * <tt>?_mobile_view=yes</tt> switches to mobile view.
    # * <tt>?_mobile_view=no</tt> switches to non-mobile view.
    # * <tt>?_mobile_view=auto</tt> don't force switch; determine by User-Agent.
    #
    # To accomplish the logic above:
    #
    #   class AppliactionController < ActionController::Base
    #     before_filter :manual_mobile_switching
    #
    #     has_mobile_view
    #
    #     protected
    #
    #     # Detects `_mobile_view` parameter.
    #     #
    #     # If it is 'yes', force turn on mobile view by setting cookie mobile=1;
    #     # if it is 'no', force turn off mobile view by setting cookie mobile=0;
    #     # if it is 'auto', remove mobile cookie and fallback to User-Agent mode;
    #     # otherwise, no effect.
    #     def mobile_switching
    #       case params[:_mobile_view]
    #       when 'yes'
    #         force_mobile!
    #       when 'no'
    #         force_non_mobile!
    #       when 'auto'
    #         dismiss_mobile_forcing!
    #     end
    #   end
    module ControllerAdditions
      protected
      # Force switch to mobile view.
      def force_mobile!
        cookies[COOKIE_NAME] = FORCE_MOBILE_VALUE
      end

      # Force switch to non-mobile (default) view.
      def force_non_mobile!
        cookies[COOKIE_NAME] = FORCE_NON_MOBILE_VALUE
      end

      # Dismiss any forced switching, and fallback to other methods like User-Agent sniffing
      def dismiss_mobile_forcing!
        cookies.delete COOKIE_NAME
      end

      # Test if currently forced to mobile or non-mobile view.
      def mobile_forcing?
        forced_mobile? || forced_non_mobile?
      end

      # Test if currently forced to mobile view.
      def forced_mobile?
        cookies[COOKIE_NAME] == FORCE_MOBILE_VALUE
      end

      # Test if currently forced to non-mobile view.
      def forced_non_mobile?
        cookies[COOKIE_NAME] == FORCE_NON_MOBILE_VALUE
      end
    end
  end
end
