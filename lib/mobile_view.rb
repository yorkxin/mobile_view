require "mobile_view/version"
require "mobile_view/engine"

require "mobile_view/resolver"

module MobileView
  @resolver = nil

  def self.resolver
    @resolver ||= Resolver.new(File.join(::Rails.root, "app", "views"))
    @resolver
  end
end
