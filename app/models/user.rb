class User < ActiveRecord::Base
  def github_client
    @github_client ||= Octokit::Client.new(access_token: access_token)
  end

  def to_param
    login
  end
end
