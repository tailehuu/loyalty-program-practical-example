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

  validates :user_id, :amount, :currency, :transaction_type, :status, presence: true
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES.values, message: "%{value} is not valid" }
  validates :status, inclusion: { in: STATUSES.values, message: "%{value} is not valid" }
end
