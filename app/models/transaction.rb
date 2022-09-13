# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  EARNING_RULES = {
    every_amount: (ENV['EARNING_RULES_EVERY_AMOUNT'] || 100).to_i,
    point: (ENV['EARNING_RULES_POINT'] || 10).to_i
  }

  SPECIAL_REWARD = ENV['SPECIAL_REWARD'] || '4x Airport Lounge Access Reward'

  TIER_RULES = {
    premium: (ENV['TIER_RULES_PREMIUM'] || 5_000).to_i,
    gold: (ENV['TIER_RULES_GOLD'] || 1_000).to_i
  }

  STATUSES = {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed'
  }.freeze

  TRANSACTION_TYPES = {
    buy: 'BUY'
  }.freeze

  belongs_to :user

  validates :user_id, :amount, :currency, :transaction_type, :status, presence: true
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES.values, message: '%{value} is not valid' }
  validates :status, inclusion: { in: STATUSES.values, message: '%{value} is not valid' }

  after_commit :create_earning_history, on: :create

  def calculate_earning_points
    @calculate_earning_points ||= begin
      earning_points = (amount.to_i / EARNING_RULES[:every_amount]) * EARNING_RULES[:point]
      earning_points *= 2 if currency != User::CURRENCIES[:usd]
      earning_points
    end
  end

  def calculate_tier
    @calculate_tier ||= begin
      points = user.point + calculate_earning_points
      if points >= TIER_RULES[:premium]
        User::TIERS[:premium]
      elsif points >= TIER_RULES[:gold]
        User::TIERS[:gold]
      else
        User::TIERS[:standard]
      end
    end
  end

  def calculate_rewards
    if calculate_tier == User::TIERS[:gold] && user.tier == User::TIERS[:standard]
      [
        Reward.find_by_name(SPECIAL_REWARD)
      ]
    else
      []
    end
  end

  def processed?
    status == STATUSES[:processed]
  end

  private

  def create_earning_history
    CreateEarningHistoryWorker.perform_in(3.seconds, id)
  end
end
