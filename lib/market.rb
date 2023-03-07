class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map{|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.select{|vendor| vendor.inventory[item] > 0}
  end

  def sorted_item_list
    @vendors.map{|vendor| 
      vendor.inventory.map{|item, stock| 
        item.name}}.flatten.uniq.sort
  end

  def overstocked_items
    item_numbers = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_numbers[item] += quantity
      end
    end
    item_numbers.select{|item, number| vendors_that_sell(item).count > 1 && number >= 50}    
  end
end
