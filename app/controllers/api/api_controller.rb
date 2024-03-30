module Api
  class ApiController < ApplicationController
    # API specific configurations, filters, etc.
    # For example, you might skip CSRF protection for JSON requests:
    skip_before_action :verify_authenticity_token
  end
end
