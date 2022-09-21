# frozen_string_literal: true

require 'rails_helper'

describe Reward do
  describe '.valid?' do
    let(:name) { 'Free Coffee Reward' }

    let(:reward) do
      build(
        :reward,
        name: name
      )
    end

    it 'returns true' do
      expect(reward.valid?).to eq true
    end

    context 'name is empty' do
      let(:name) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(reward.valid?).to eq false
        expect(reward.errors[:name]).to eq errors
      end
    end

    context 'name has already exists' do
      let(:errors) { ['has already been taken'] }

      before do
        create(:reward, name: name)
      end

      it 'returns false' do
        expect(reward.valid?).to eq false
        expect(reward.errors[:name]).to eq errors
      end
    end
  end
end
