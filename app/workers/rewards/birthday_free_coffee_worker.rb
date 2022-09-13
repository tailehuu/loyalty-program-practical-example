# frozen_string_literal: true

module Rewards
  class BirthdayFreeCoffeeWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform(timestamp)
      puts "call Rewards::BirthdayFreeCoffeeService.new(#{timestamp}).execute"
    end
  end
end
