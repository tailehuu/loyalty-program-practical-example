# frozen_string_literal: true

require 'rails_helper'

describe EarningHistory do
  describe '.valid?' do
    let(:user) { create(:user) }
    let(:point) { 10 }

    let(:earning_history) do
      build(
        :earning_history,
        user: user,
        point: point
      )
    end

    it 'returns true' do
      expect(earning_history.valid?).to eq true
    end

    context 'user_id is empty' do
      let(:user) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(earning_history.valid?).to eq false
        expect(earning_history.errors[:user_id]).to eq errors
      end
    end

    context 'point is empty' do
      let(:point) { nil }
      let(:errors) { ["can't be blank", 'is not a number'] }

      it 'returns false' do
        expect(earning_history.valid?).to eq false
        expect(earning_history.errors[:point]).to eq errors
      end
    end

    context 'point is smaller than zero' do
      let(:point) { -10 }
      let(:errors) { ['must be greater than or equal to 0'] }

      it 'returns false' do
        expect(earning_history.valid?).to eq false
        expect(earning_history.errors[:point]).to eq errors
      end
    end
  end
end
