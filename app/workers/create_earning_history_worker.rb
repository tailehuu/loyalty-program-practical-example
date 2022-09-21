# frozen_string_literal: true

class CreateEarningHistoryWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(transaction_id)
    service = CreateEarningHistoryService.new(transaction_id)
    if service.execute
      puts service.message
    else
      puts service.error
    end
  end
end
