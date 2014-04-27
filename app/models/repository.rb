class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :pull_requests

  scope :contributed, -> { where(contributed: true) }

  def full_name
    "#{owner}/#{name}"
  end
end
