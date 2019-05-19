class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user #tells rails we wish to use this in our helpers and views as well

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to '/login' unless current_user
  end
end
