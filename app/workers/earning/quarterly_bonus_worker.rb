# frozen_string_literal: true

module Earning
  class QuarterlyBonusWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'loyalty_q'

    def perform(timestamp)
      puts "call Earning::QuarterlyBonusService.new(#{timestamp}).execute"
    end
  end
end
