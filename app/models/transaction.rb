# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  STATUSES = {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed'
  }.freeze

  TRANSACTION_TYPES = {
    buy: 'BUY'
  }.freeze

  belongs_to :user

  validates :user_id, :amount, :currency, presence: true
  validates :transaction_type,
            presence: true,
            inclusion: { in: TRANSACTION_TYPES.values, message: "%{value} is not valid" }
  validates :status,
            presence: true,
            inclusion: { in: STATUSES.values, message: "%{value} is not valid" }
end
