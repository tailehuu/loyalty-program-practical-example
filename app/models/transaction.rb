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

# transactions:
# after create transaction
# - enqueue CreateEarningHistoryWorker.perform_async(transaction_id)
#     - call CreateEarningHistoryService.execute(transaction_id)
#         - transaction = Transaction.find(transaction_id)
#         - earning_points = transaction.cal_earning_points
#         - user.earning_histories.create(point: earning_points)
#         - user.update_attributes(point: user.point + earning_points)
# users:
# after update on point attribute
# - enqueue UpdateUserTierWorker.perform_async(user_id)