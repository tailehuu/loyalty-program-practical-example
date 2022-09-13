# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clean up data
Reward.delete_all
User.all.map(&:destroy)

# create rewards
[
  'Free Coffee Reward',
  '5% Cash Rebate Reward',
  'Free Movie Ticket Reward',
  '4x Airport Lounge Access Reward'
].each do |name|
  Reward.create(name: name)
end

# create users
User.create!([
               { name: 'Tony LE', dob: '1981-04-18', tier: User::TIERS[:standard] },
               { name: 'Wendy LE', dob: '2015-02-05', tier: User::TIERS[:gold] },
               { name: 'Jacky LE', dob: '2016-11-19', tier: User::TIERS[:premium], currency: User::CURRENCIES[:eur] }
             ])
