class PagesController < ApplicationController
  def index
    redirect_to user_path(@login_user) if @login_user.present?
  end
end
