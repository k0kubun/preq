class User < ActiveRecord::Base
  has_many :repositories

  alias_method :contributed, :repositories

  def github_client
    @github_client ||= Octokit::Client.new(access_token: access_token)
  end

  def to_param
    login
  end
end
