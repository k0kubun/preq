class UsersController < ApplicationController
  before_action :login_required, only: [:update]

  def show
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.where(login: params[:id]).first_or_create
    load_repositories
    load_pull_requests
    redirect_to user_path(@user)
  end

  private

  def load_repositories
    github_repositories = @login_user.github_client.repositories(@user.login, with_parent: true)
    github_repositories.each do |github_repository|
      github_repository = github_repository.parent || github_repository

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

  def load_pull_requests
    @user.repositories.each do |repository|
      open_pull_requests = @login_user.github_client.pull_requests(repository.full_name, state: 'open')
      closed_pull_requests = @login_user.github_client.pull_requests(repository.full_name, state: 'closed')

      (open_pull_requests + closed_pull_requests).each do |github_pull_request|
        next if github_pull_request.user.try(:login) != @user.login

        pull_request = PullRequest.where(
          repository_id: repository.id,
          number: github_pull_request.number,
        ).first_or_create

        pull_request.update(
          state: merged_including_state(github_pull_request),
          title: github_pull_request.title,
          url: github_pull_request.html_url,
        )
      end
    end
  end

  def merged_including_state(github_pull_request)
    if github_pull_request.state == 'closed' && github_pull_request.merged_at.present?
      'merged'
    else
      github_pull_request.state
    end
  end
end
