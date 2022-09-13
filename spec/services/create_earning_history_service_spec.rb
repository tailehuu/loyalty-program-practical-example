# frozen_string_literal: true

require 'rails_helper'

describe CreateEarningHistoryService do
  describe '#execute' do
    let(:user) do
      create(
        :user,
        point: 0,
        tier: User::TIERS[:standard],
        currency: User::CURRENCIES[:usd]
      )
    end
    let(:amount) { 1_000 }
    let(:earning_points) { 100 }
    let(:currency) { User::CURRENCIES[:usd] }
    let(:status) { Transaction::STATUSES[:pending] }
    let!(:transaction) do
      create(
        :transaction,
        user: user,
        amount: amount,
        currency: currency,
        status: status
      )
    end
    let(:transaction_id) { transaction.id }


    subject { described_class.new(transaction_id) }

    context 'transaction id does not find' do
      let(:transaction_id) { -1 }
      let(:error) { 'transaction_id_does_not_find' }

      it 'returns false with error' do
        expect(subject.execute).to eq false
        expect(subject.error).to eq error
      end
    end

    context 'transaction is processed' do
      let(:error) { 'transaction_is_processed' }

      before do
        transaction.update_attributes(status: Transaction::STATUSES[:processed])
      end

      it 'returns false with error' do
        expect(subject.execute).to eq false
        expect(subject.error).to eq error
      end
    end

    it 'returns true with message' do
      expect(subject.execute).to eq true
      expect(subject.message).to eq 'done'
    end

    it 'updates user info correctly' do
      expect(subject.execute).to eq true

      expect(user.reload.point).to eq earning_points
      expect(user.tier).to eq User::TIERS[:standard]
    end

    it 'creates earning history correctly' do
      expect(subject.execute).to eq true

      earning_history = EarningHistory.last
      expect(earning_history.user_id).to eq user.id
      expect(earning_history.point).to eq earning_points
      expect(earning_history.note).to eq "Earn #{earning_points} points from transaction id #{transaction_id}"
    end

    it 'updates transaction status correctly' do
      expect(subject.execute).to eq true

      expect(transaction.reload.status).to eq Transaction::STATUSES[:processed]
    end

    context 'foreign currency' do
      let(:currency) { User::CURRENCIES[:eur] }
      let(:earning_points) { 200 }

      it 'earning points are 2x the standard points' do
        expect(subject.execute).to eq true

        expect(user.reload.point).to eq earning_points
        expect(user.tier).to eq User::TIERS[:standard]
      end
    end

    context 'user becomes a gold tier customer' do
      let(:name) { '4x Airport Lounge Access Reward' }
      let!(:reward) { create :reward, name: name }

      before do
        user.update_attributes(point: 900)
      end

      it "receives '4x Airport Lounge Access Reward'" do
        expect(subject.execute).to eq true

        user_reward = UserReward.last
        expect(user_reward.user_id).to eq user.id
        expect(user_reward.reward_id).to eq reward.id
      end
    end
  end
end
