class User < ActiveRecord::Base
  CURRENCIES = {
    eur: 'EUR',
    usd: 'USD',
    sgd: 'SGD'
  }

  TIERS = {
    standard: 'standard',
    gold: 'gold',
    premium: 'premium'
  }

  has_many :points
  has_many :rewards, through: :user_rewards
  has_many :transactions
  has_many :user_rewards

  validates :name, presence: :true
  validates :tier,
            presence: :true,
            inclusion: { in: TIERS.values, message: "%{value} is not valid" }
  validates :currency,
            inclusion: { in: CURRENCIES.values, message: "%{value} is not valid" }
end
