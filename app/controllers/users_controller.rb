class UsersController < ApplicationController
  before_action :login_required, only: [:update]

  def show
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.where(login: params[:id]).first_or_create
    load_repositories
    redirect_to user_path(@user)
  end

  private

  def load_repositories
    github_repositories = @login_user.github_client.repositories(@user.login)
    github_repositories.each do |github_repository|
      repository = Repository.where(
        user_id: @user.id,
        name: github_repository.name,
        owner: github_repository.owner.login,
      ).first_or_create

      repository.update(
        url: github_repository.html_url,
        stargazers_count: github_repository.stargazers_count,
      )
    end
  end
end
