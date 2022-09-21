FactoryGirl.define do
  factory :user_reward do
    user_id { 1 }
    reward_id { 1 }
    status { UserReward::STATUSES[:pending] }
  end
end
