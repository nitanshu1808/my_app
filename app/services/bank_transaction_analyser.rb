require 'byebug'

class BankTransactionAnalyser
  attr_accessor :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def balances
    return {} if transactions.empty?

    customer_balances = {}
    transactions.each do |customer, transactions|
      total_credit = 0
      transactions.each do |transaction|
        total_credit += transaction[:amount] if transaction[:type] == "credit"
      end

      customer_balances[customer] = total_credit
    end

    customer_balances
  end

  def highest_balance
    return 'N/A' if transactions.empty?

    customer_with_highest_bal, max_balance = nil, 0

    transactions.each do |customer, transactions|
      balance = 0

      transactions.each do |transaction|
        if transaction[:type] == 'credit'
          balance = balance + transaction[:amount]
        elsif transaction[:type] == 'debit'
          balance = balance - transaction[:amount]
        end
      end

      max_balance = balance if max_balance.nil?
      customer_with_highest_bal = customer if customer_with_highest_bal.nil?

      if max_balance.nil? || balance > max_balance
        max_balance = balance
        customer_with_highest_bal = customer
      end
    end

    customer_with_highest_bal
  end

  def fraudulent_customers
    return 'N/A' if transactions.empty?

    fraud_customers = []

    transactions.each do |customer, transactions|
      balance = 0

      transactions.each do |transaction|
        balance += transaction[:amount] if transaction[:type] == 'credit'
        balance -= transaction[:amount] if transaction[:type] == 'debit'
      end

      fraud_customers << customer if balance < 0
    end

    fraud_customers
  end

  def sorted_transactions
    return [] if transactions.empty?

    all_transactions = []

    transactions.each do |customer, transactions|
      transactions.each do |transaction|
        all_transactions << { customer: customer, **transaction }
      end      
    end

    all_transactions.sort_by{ |obj| -obj[:amount] }
  end
end


# Scenario:
# You are building a bank transaction analyzer for customers. Each customer has:

# A name
# A list of transactions (each transaction has amount and type: "credit" or "debit")

# Task:
# Calculate the total balance for each customer.
# Find the customer with the highest balance.
# List all transactions sorted by amount (descending).
# Detect fraudulent customers (customers who have a negative balance).


# Sample Input:
customers = {
  "Alice" => [{ amount: 500, type: "credit" }, { amount: 100, type: "debit" }],
  "Bob" => [{ amount: 200, type: "debit" }, { amount: 1000, type: "credit" }],
  "Charlie" => [{ amount: 50, type: "debit" }, { amount: 100, type: "debit" }]
}


# Expected Output:
# balances => { "Alice" => 400, "Bob" => 800, "Charlie" => -50 }
# highest_balance => "Bob"
# sorted_transactions => [{amount: 1000, type: "credit"}, {amount: 500, type: "credit"}, ...]
# fraudulent_customers => ["Charlie"]

