# frozen_string_literal: true

require 'rails_helper'

describe Point do
  describe '.valid?' do
    let(:user) { create(:user) }
    let(:value) { 10 }

    let(:point) do
      build(
        :point,
        user: user,
        point: value
      )
    end

    it 'returns true' do
      expect(point.valid?).to eq true
    end

    context 'user_id is empty' do
      let(:user) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(point.valid?).to eq false
        expect(point.errors[:user_id]).to eq errors
      end
    end

    context 'point is empty' do
      let(:value) { nil }
      let(:errors) { ["can't be blank", 'is not a number'] }

      it 'returns false' do
        expect(point.valid?).to eq false
        expect(point.errors[:point]).to eq errors
      end
    end

    context 'point is smaller than zero' do
      let(:value) { -10 }
      let(:errors) { ['must be greater than or equal to 0'] }

      it 'returns false' do
        expect(point.valid?).to eq false
        expect(point.errors[:point]).to eq errors
      end
    end
  end
end
