FactoryGirl.define do
  factory :transaction do
    user_id { 1 }
    amount { 100 }
    currency { User::CURRENCIES[:usd] }
    transaction_type { Transaction::TRANSACTION_TYPES[:buy] }
    status { Transaction::STATUSES[:processed] }
  end
end
