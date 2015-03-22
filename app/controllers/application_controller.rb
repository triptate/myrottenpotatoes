class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_user

  before_filter :set_config
  Tmdb::Api.key("e44bf5bd2b7762030e6a298a22d086e7")

  def set_config
	@configuration = Tmdb::Configuration.new
  end

  protected # prevents following method from being invoked by a route
  
  def set_current_user
  	@current_user ||= Moviegoer.find_by_id(session[:user_id])
  	# redirect_to login_path and return unless @current_user
  end

end
