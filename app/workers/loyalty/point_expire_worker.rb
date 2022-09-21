# frozen_string_literal: true

module Loyalty
  class PointExpireWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'loyalty_q'

    def perform(timestamp)
      puts "call Loyalty::PointExpireService.new(#{timestamp}).execute"
    end
  end
end
