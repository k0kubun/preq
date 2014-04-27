class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :pull_requests

  def full_name
    "#{owner}/#{name}"
  end
end
