module MobileView
  module ForcedSwitching
    COOKIE_NAME = "mobile"
    FORCE_MOBILE_VALUE = "1"
    FORCE_NON_MOBILE_VALUE = "0"

    # These controller additions are helpers that you can use
    # in your controller to test if currently it is forcely (manually) switched to mobile 
    # version, or non-mobile version.
    #
    # By force-switching to either version, MobileView will take it at the top
    # precedence, and ignore the ascending methods (e.g. by User-Agent).
    #
    # They will be automatically included into the controller
    # that includes {MobileView::ControllerAdditions}. You don't need to
    # <tt>include</tt> them manually.
    #
    # TODO: Unit Testing
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
