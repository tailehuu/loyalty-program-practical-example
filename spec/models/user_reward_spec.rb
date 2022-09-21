# frozen_string_literal: true

require 'rails_helper'

describe UserReward do
  describe '.valid?' do
    let(:user) { create :user }
    let(:reward) { create :reward }
    let(:status) { UserReward::STATUSES[:pending] }

    let(:user_reward) do
      build(
        :user_reward,
        user: user,
        reward: reward,
        status: status
      )
    end

    it 'returns true' do
      expect(user_reward.valid?).to eq true
    end

    context 'user_id is empty' do
      let(:user) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(user_reward.valid?).to eq false
        expect(user_reward.errors[:user_id]).to eq errors
      end
    end

    context 'reward_id is empty' do
      let(:reward) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(user_reward.valid?).to eq false
        expect(user_reward.errors[:reward_id]).to eq errors
      end
    end

    context 'status is empty' do
      let(:status) { nil }
      let(:errors) { ["can't be blank", ' is not valid'] }

      it 'returns false' do
        expect(user_reward.valid?).to eq false
        expect(user_reward.errors[:status]).to eq errors
      end
    end

    context 'status is invalid' do
      let(:status) { 'DONE' }
      let(:errors) { ['DONE is not valid'] }

      it 'returns false' do
        expect(user_reward.valid?).to eq false
        expect(user_reward.errors[:status]).to eq errors
      end
    end
  end
end
