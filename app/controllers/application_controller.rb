class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :set_cache_headers

  private
  
  def set_cache_headers
    response.headers["Cache-Control"] = "no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
