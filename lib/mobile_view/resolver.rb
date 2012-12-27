module MobileView

  # Resolver for mobile view templates; search for +*.mobile+ templates.
  #
  # When invoking {ControllerAdditions::ClassMethods#has_mobile_view has_mobile_view}, and MobileView thinks
  # it should choose mobile version first, this resolver will be prepended to the
  # existing +view_paths+, makes it become the first precedence of template searching.
  #
  # Searching is done by finding templates with the following pattern, which is same as
  # the convension of template file naming rule, except for +.mobile+ injection:
  #
  #   prefix/action.mobile.locale.formats.handlers
  #                ^^^^^^^
  #                hard-coded
  #
  # Pattern is modified from {https://github.com/rails/rails/blob/v3.2.9/actionpack/lib/action_view/template/resolver.rb#L106 ActionView::PathResolver}
  #
  # == Algorithm Explanation
  #
  # For example, when there exists the following two templates:
  #
  # * posts/show.html.erb
  # * posts/show.mobile.html.erb
  #
  # When MobileView thinks currently it is switched to mobile version (see {ControllerAdditions#mobile?}),
  # then a {Resolver} will be prepended to the search pathes,
  # and Rails will get +posts/show.mobile.html.erb+ as the first available template.
  # When MobileView thinks it is not switched to mobile version, then this {Resolver} will not be
  # prepended, and Rails will search for templates as usual.
  #
  # Since Rails's template searching is implemented by auto-fallback strategy,
  # if a corresponding +*.mobile+ doesn't exist, then this {Resolver}
  # will return nothing, and Rails will automatically use other resolvers.
  #
  class Resolver < ::ActionView::FileSystemResolver
    # <tt>prefix/action<b>.mobile</b>.locale.formats.handlers</tt>
    #
    # Example: <tt>posts/show<b>.mobile</b>.html.erb</tt>
    MOBILE_PATTERN = ":prefix/:action.mobile{.:locale,}{.:formats,}{.:handlers,}"

    def initialize(path)
      super(path, MOBILE_PATTERN)
    end
  end
end
