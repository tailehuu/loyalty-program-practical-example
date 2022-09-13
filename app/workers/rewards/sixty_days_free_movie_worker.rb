# frozen_string_literal: true

module Rewards
  class SixtyDaysFreeMovieWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform(user_id)
      puts "call Rewards::SixtyDaysFreeMovieService.new(#{user_id}).execute"
    end
  end
end
