class UsersController < ApplicationController
  before_action :login_required, only: [:update]

  def show
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.where(login: params[:id]).first_or_create
    redirect_to user_path(@user)
  end
end
