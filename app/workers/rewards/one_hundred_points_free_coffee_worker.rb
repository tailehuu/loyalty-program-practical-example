# frozen_string_literal: true

module Rewards
  class OneHundredPointsFreeCoffeeWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform(timestamp)
      puts "call Rewards::OneHundredPointsFreeCoffeeService.new(#{timestamp}).execute"
    end
  end
end
