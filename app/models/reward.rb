# frozen_string_literal: true

class Reward < ActiveRecord::Base
  has_many :users, through: :user_rewards
  has_many :user_rewards
end
