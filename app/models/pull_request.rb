class PullRequest < ActiveRecord::Base
  belongs_to :repository

  scope :merged, -> { where(state: 'merged') }
  scope :closed, -> { where(state: 'closed') }
  scope :open, -> { where(state: 'open') }
end
