module MobileView
  class Resolver < ::ActionView::FileSystemResolver
    MOBILE_PATTERN = ":prefix/:action.mobile{.:locale,}{.:formats,}{.:handlers,}"

    def initialize(path)
      super(path, MOBILE_PATTERN)
    end
  end
end
