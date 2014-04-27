class User < ActiveRecord::Base
  has_many :repositories
  has_many :pull_requests, through: :repositories

  alias_method :contributed, :repositories
  define_method :merged, -> { pull_requests.merged }
  define_method :closed, -> { pull_requests.closed }
  define_method :open, -> { pull_requests.open }

  def github_client
    @github_client ||= Octokit::Client.new(access_token: access_token)
  end

  def to_param
    login
  end
end
