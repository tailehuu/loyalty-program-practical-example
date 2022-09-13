# frozen_string_literal: true

class User < ActiveRecord::Base
  CURRENCIES = {
    eur: 'EUR',
    usd: 'USD',
    sgd: 'SGD'
  }.freeze

  TIERS = {
    standard: 'standard',
    gold: 'gold',
    premium: 'premium'
  }.freeze

  has_many :earning_histories, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :transactions, dependent: :destroy
  has_many :user_rewards, dependent: :destroy

  validates :name, :point, :tier, :currency, presence: true
  validates :point, numericality: { greater_than_or_equal_to: 0 }
  validates :tier, inclusion: { in: TIERS.values, message: '%{value} is not valid' }
  validates :currency, inclusion: { in: CURRENCIES.values, message: '%{value} is not valid' }
end
