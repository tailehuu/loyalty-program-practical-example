# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  DEFAULT_EARNING_POINTS = (ENV['DEFAULT_EARNING_POINTS'] || 10).to_i

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
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES.values, message: "%{value} is not valid" }
  validates :status, inclusion: { in: STATUSES.values, message: "%{value} is not valid" }

  after_commit :create_earning_history, on: :create


  def calculate_earning_points
    @calculate_earning_points ||= begin
      earning_points = (amount.to_i / 100) * DEFAULT_EARNING_POINTS
      earning_points = earning_points * 2 if currency != User::CURRENCIES[:usd]
      earning_points
    end
  end

  def calculate_tier
    @calculate_tier ||= begin
                    points = user.point + calculate_earning_points
                    case
                    when points >= 5_000
                      User::TIERS[:premium]
                    when points >= 1_000
                      User::TIERS[:gold]
                    else
                      User::TIERS[:standard]
                    end
                  end
  end

  def calculate_rewards
    if calculate_tier == User::TIERS[:gold] && user.tier == User::TIERS[:standard]
      [
        Reward.find_by_name('4x Airport Lounge Access Reward')
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
