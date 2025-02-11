class Ecommerce
  attr_accessor :orders

  def initialize(orders:)
    @orders = orders
  end

  def total_revenue_for_orders
    total = 0
    orders.each do |order|
      order[:items].each do |item|
        total += item[:price] * item[:quantity]
      end
    end

    total
  end

  def group_order_by_status
    group = {}

    orders.each do |order|
      if group[order[:status]]
        group[order[:status]] = [order]
      else
        group[order[:status]] << order
      end
    end

    group
  end

  # Find the top customer who spent the most money.
  def most_spend_by_customer
    max = 0
    total_per_customer = 0
    customer = ''

    orders.each do |order|
      order[:items].each do |item|
        total_per_customer += item[:price] * item[:quantity]
      end

      if total_per_customer > max
        max = total_per_customer
        customer = order[:customer]
      end
    end

    customer
  end

  def unique_products_with_quantity
    products_with_quantity = {}

    orders.each do |order|
      order[:items].each do |item|
        if products_with_quantity[item[:name]]
          products_with_quantity[item[:name]] = 1
        else
          products_with_quantity[item[:name]] += 1
        end
      end
    end
  end
end


orders = [
  { id: 1, customer: "Alice", items: [{ name: "Laptop", price: 1000, quantity: 1 }, { name: "Mouse", price: 50, quantity: 2 }], status: "shipped" },
  { id: 2, customer: "Bob", items: [{ name: "Laptop", price: 1000, quantity: 2 }], status: "pending" },
  { id: 3, customer: "Alice", items: [{ name: "Keyboard", price: 100, quantity: 1 }], status: "delivered" },
  { id: 4, customer: "Charlie", items: [{ name: "Monitor", price: 300, quantity: 1 }], status: "shipped" },
]