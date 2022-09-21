require 'clockwork'
require 'active_support/time'

require_relative '../config/boot'
require_relative '../config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # Issuing Rewards Rules
  # ========
  #
  # Level 1
  # 1. If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward
  every 1.month, '100 points, Free Coffee reward', at: '00:00', tz: 'UTC' do
    timestamp = Time.zone.now.utc.change(sec: 0).to_i
    Rewards::OneHundredPointsFreeCoffeeWorker.perform_async(timestamp)
  end

  # Level 2
  # 1. A Free Coffee reward is given to all users during their birthday month
  every 1.month, 'Birthday, Free Coffee reward', at: '00:00', tz: 'UTC' do
    timestamp = Time.zone.now.utc.change(sec: 0).to_i
    Rewards::BirthdayFreeCoffeeWorker.perform_async(timestamp)
  end

  # 2. A 5% Cash Rebate reward is given to all users who have 10 or more transactions that have an amount > $100
  #   Question: What is the time frame? A day, a week or a month ?

  # Loyalty Rules
  # ========
  #
  # Level 2
  # 1. Points expire every year
  every 1.year, 'Point expire checker', at: '00:00', tz: 'UTC' do
    timestamp = Time.zone.now.utc.change(sec: 0).to_i
    Loyalty::PointExpireWorker.perform_async(timestamp)
  end

  # 4. Every calendar quarterly give 100 bonus points for any user spending greater than $2000 in that quarter
  every 3.months, '100 bonus points', at: '00:00', tz: 'UTC' do
    timestamp = Time.zone.now.utc.change(sec: 0).to_i
    Earning::QuarterlyBonusWorker.perform_async(timestamp)
  end
end
