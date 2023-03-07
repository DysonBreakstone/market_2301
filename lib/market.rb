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

  def 
end
