class ApplicationController < ActionController::Base

  include ActiveModel::ForbiddenAttributesProtection

  protect_from_forgery
  before_filter :configure_permitted_parameters, :if => :devise_controller?
	
protected
def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end

	after_filter :store_location

def store_location
  # store last url as long as it isn't a /users path
  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end
end
