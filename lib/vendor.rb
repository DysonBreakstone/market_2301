class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end
  
  def potential_revenue
    rev = 0.0
    @inventory.each{|item, stock| rev += (item.price * stock).round(2)}
    rev
  end

  def sell(item, quantity)
    @inventory[item] -= quantity if check_stock(item) >= quantity
  end
end
