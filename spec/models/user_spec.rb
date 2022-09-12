require 'rails_helper'

describe User do
  describe '.valid?' do
    let(:name) { 'Tai LE' }
    let(:tier) { User::TIERS[:standard] }
    let(:currency) { User::CURRENCIES[:usd] }

    let(:user) { build(:user, name: name, tier: tier, currency: currency) }

    it 'returns true' do
      expect(user.valid?).to eq true
    end

    context 'name is empty' do
      let(:name) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(user.valid?).to eq false
        expect(user.errors[:name]).to eq errors
      end
    end

    context 'tier is invalid' do
      let(:tier) { 'VIP' }
      let(:errors) { ['VIP is not valid'] }

      it 'returns false' do
        expect(user.valid?).to eq false
        expect(user.errors[:tier]).to eq errors
      end
    end

    context 'currency is invalid' do
      let(:currency) { 'VND' }
      let(:errors) { ['VND is not valid'] }

      it 'returns false' do
        expect(user.valid?).to eq false
        expect(user.errors[:currency]).to eq errors
      end
    end
  end
end
