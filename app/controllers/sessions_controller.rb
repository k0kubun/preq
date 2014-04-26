class SessionsController < ApplicationController
  GITHUB_URL = 'https://github.com'

  def new
    redirect_to oauth2_client.auth_code.authorize_url(redirect_uri: sessions_url)
  end

  def create
    access_token = oauth2_client.auth_code.get_token(params[:code], redirect_uri: root_url).token
    redirect_to root_path if access_token.blank?

    authorize(access_token)
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def authorize(access_token)
    github_user = User.new(access_token: access_token).github_client.user
    @login_user = User.where(login: github_user.login).first_or_create
    @login_user.update(access_token: access_token, avatar_url: github_user.avatar_url)
    session[:login] = @login_user.login
  end

  def oauth2_client
    @client ||= OAuth2::Client.new(
      ENV['GITHUB_CLIENT_ID'],
      ENV['GITHUB_CLIENT_SECRET'],
      site: GITHUB_URL,
      authorize_url: '/login/oauth/authorize',
      token_url: '/login/oauth/access_token',
    )
  end
end
