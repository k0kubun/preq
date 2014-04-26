class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_login_user

  private

  def set_login_user
    return if session[:login].blank?
    @login_user ||= User.find_by_login(session[:login])
    reset_session if @login_user.blank?
  end
end
