# frozen_string_literal: true

require 'rails_helper'

describe Transaction do
  describe '.valid?' do
    let(:user) { create(:user) }
    let(:amount) { 100 }
    let(:currency) { User::CURRENCIES[:usd] }
    let(:transaction_type) { Transaction::TRANSACTION_TYPES[:buy] }
    let(:status) { Transaction::STATUSES[:processed] }

    let(:transaction) do
      build(
        :transaction,
        user: user,
        amount: amount,
        currency: currency,
        transaction_type: transaction_type,
        status: status
      )
    end

    it 'returns true' do
      expect(transaction.valid?).to eq true
    end

    context 'user_id is empty' do
      let(:user) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:user_id]).to eq errors
      end
    end

    context 'amount is empty' do
      let(:amount) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:amount]).to eq errors
      end
    end

    context 'currency is empty' do
      let(:currency) { nil }
      let(:errors) { ["can't be blank"] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:currency]).to eq errors
      end
    end

    context 'transaction_type is empty' do
      let(:transaction_type) { nil }
      let(:errors) { ["can't be blank", ' is not valid'] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:transaction_type]).to eq errors
      end
    end

    context 'transaction_type is invalid' do
      let(:transaction_type) { 'BUY-SOMETHING' }
      let(:errors) { ['BUY-SOMETHING is not valid'] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:transaction_type]).to eq errors
      end
    end

    context 'status is empty' do
      let(:status) { nil }
      let(:errors) { ["can't be blank", ' is not valid'] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:status]).to eq errors
      end
    end

    context 'status is invalid' do
      let(:status) { 'COMPLETED' }
      let(:errors) { ['COMPLETED is not valid'] }

      it 'returns false' do
        expect(transaction.valid?).to eq false
        expect(transaction.errors[:status]).to eq errors
      end
    end
  end
end
