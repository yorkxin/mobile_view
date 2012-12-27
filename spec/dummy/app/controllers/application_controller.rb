class ApplicationController < ActionController::Base
  protect_from_forgery

  has_mobile_view
end
