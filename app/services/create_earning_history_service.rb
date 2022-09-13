# frozen_string_literal: true

class CreateEarningHistoryService
  include ServiceHelper

  def initialize(transaction_id)
    @transaction_id = transaction_id
  end

  def execute
    return false_with_error('transaction_id_does_not_find') if transaction.blank?
    return false_with_error('transaction_is_processed') if transaction.processed?

    update_status_transaction(Transaction::STATUSES[:processing])
    ActiveRecord::Base.transaction do
      create_user_rewards
      create_earning_history
      update_user
      update_status_transaction(Transaction::STATUSES[:processed])
    end

    true_with_message('done')
  rescue StandardError => e
    false_with_error(e.message)
  end

  private

  attr_reader :transaction_id

  def update_status_transaction(status)
    transaction.update_attributes(status: status)
  end

  def create_user_rewards
    transaction.calculate_rewards.each do |reward|
      user.user_rewards.create!(reward: reward, status: UserReward::STATUSES[:pending])
    end
  end

  def create_earning_history
    note = "Earn #{earning_points} points from transaction id #{transaction_id}"
    user.earning_histories.create(point: earning_points, note: note)
  end

  def update_user
    user.update_attributes(point: user.point + earning_points, tier: transaction.calculate_tier)
  end

  def transaction
    @transaction ||= Transaction.find_by_id transaction_id
  end

  def user
    @user ||= transaction.user
  end

  def earning_points
    @earning_points ||= transaction.calculate_earning_points
  end
end
