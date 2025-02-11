require 'rails_helper'

RSpec.describe BankTransactionAnalyser do

  let(:bank_transaction_analyser) { described_class.new(transactions) }

  let(:transactions) do
    {
      "Alice" => [{ amount: 500, type: "credit" }, { amount: 100, type: "debit" }],
      "Bob" => [{ amount: 200, type: "debit" }, { amount: 1000, type: "credit" }],
      "Charlie" => [{ amount: 50, type: "debit" }, { amount: 100, type: "debit" }]
    }
  end

  describe "#balances" do
    subject { bank_transaction_analyser.balances }

    let(:expected_outcome) do
      {
        "Alice" => 500,
        "Bob" => 1000,
        "Charlie" => 0,
      }
    end

    it { is_expected.to eql(expected_outcome) }

    context "when transactions are empty" do
      let(:transactions) { {} }

      it { is_expected.to eql({}) }
    end
  end

  describe '#highest_balance' do
    subject { bank_transaction_analyser.highest_balance }

    let(:expected_outcome) { 'Bob' }

    it { is_expected.to eql(expected_outcome) }
  end

  describe '#fraudulent_customers' do
    subject { bank_transaction_analyser.fraudulent_customers }

    let(:expected_outcome) { ["Charlie"] }

    it { is_expected.to eql(expected_outcome) }
  end

  describe '#sorted_transactions' do
    subject { bank_transaction_analyser.sorted_transactions }

    let(:expected_outcome) do
      [
        {:customer=>"Bob", :amount=>1000, :type=>"credit"},
        {:customer=>"Alice", :amount=>500, :type=>"credit"},
        {:customer=>"Bob", :amount=>200, :type=>"debit"},
        {:customer=>"Alice", :amount=>100, :type=>"debit"},
        {:customer=>"Charlie", :amount=>100, :type=>"debit"},
        {:customer=>"Charlie", :amount=>50, :type=>"debit"}
      ]
    end

    it { is_expected.to eql(expected_outcome) }
  end
end
