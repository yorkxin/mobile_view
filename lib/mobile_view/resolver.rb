module MobileView
  class Resolver < ::ActionView::FileSystemResolver
    # pattern is modified from ActionView
    # https://github.com/rails/rails/blob/v3.2.9/actionpack/lib/action_view/template/resolver.rb#L106
    MOBILE_PATTERN = ":prefix/:action.mobile{.:locale,}{.:formats,}{.:handlers,}"

    def initialize(path)
      super(path, MOBILE_PATTERN)
    end
  end
end
