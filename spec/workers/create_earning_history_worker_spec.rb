# frozen_string_literal: true

require 'rails_helper'

describe CreateEarningHistoryWorker do
  let(:transaction_id) { 1 }
  let(:service) do
    double(
      CreateEarningHistoryService,
      execute: true,
      message: 'done'
    )
  end

  subject { described_class.new }

  it 'call to CreateEarningHistoryService' do
    expect(CreateEarningHistoryService).to receive(:new).and_return(service)
    expect(service).to receive(:execute)

    subject.perform(transaction_id)
  end
end
