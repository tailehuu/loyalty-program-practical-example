# frozen_string_literal: true

class CreateEarningHistoryWorker
  include Sidekiq::Worker

  def perform(transaction_id)
    puts "call CreateEarningHistoryService.execute(#{transaction_id})"
  end
end
