class User < ActiveRecord::Base
  has_many :points
  has_many :rewards, through: :user_rewards
  has_many :transactions
  has_many :user_rewards
end
