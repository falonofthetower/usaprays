class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "templates/application"

  before_filter :get_ip
  helper_method :usaprays?

  def get_ip
    @client_ip = request.remote_ip
    @client_ip_forwarded = request.env["HTTP_X_FORWARDED_FOR"]
  end

  def usaprays?
    request.env["HTTP_HOST"].include? "usaprays.org"
  end

end
