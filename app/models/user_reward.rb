# frozen_string_literal: true

class UserReward < ActiveRecord::Base
  STATUSES = {
    pending: 'pending',
    completed: 'completed'
  }

  belongs_to :reward
  belongs_to :user

  validates :user_id, :reward_id, :status, presence: true
  validates :status, inclusion: { in: STATUSES.values, message: "%{value} is not valid" }
end
