require 'byebug'

class Marketplace
  attr_accessor :product_list

  def initialize
    @product_list = []
  end

  def add_product(product)
    product_list << product
  end

  def sort(order: :asc)
    if order == :asc
      product_list.sort_by { |product| product.name }
    elsif order == :desc
      product_list.sort_by { |product| product.name }.reverse
    end
  end

  def search(word)
    product_list.select { |product| product.name =~ /#{word}/i }
  end
end


class Product
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

def main
  product_one = Product.new('Shoe')
  product_two = Product.new('Jacket')
  product_three = Product.new('Jeans')
  market_place = Marketplace.new
  market_place.add_product(product_one)
  market_place.add_product(product_two)
  market_place.add_product(product_three)

  puts market_place.sort
  puts market_place.sort(order: :desc)
  puts market_place.search('sh')
end

main
