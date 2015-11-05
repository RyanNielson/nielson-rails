class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def require_login
    unless user_signed_in?
      deny_access
    end
  end

  private

  def deny_access
    flash[:danger] = "You must be logged in to view this resource."
    redirect_to root_url
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  helper_method :current_user, :user_signed_in?
end
