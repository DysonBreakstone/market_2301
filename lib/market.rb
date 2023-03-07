class Market
  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Time.now.strftime("%d/%m/%Y")
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
    count_items.select{|item, number| vendors_that_sell(item).count > 1 && number >= 50}    
  end

  def total_inventory
    all_items = Hash.new
    item_object_list =  @vendors.map{|vendor| 
                          vendor.inventory.map{|item, stock| 
                            item}}.flatten.uniq
    item_object_list.each do |item|
      all_items[item.name] = Hash.new
      all_items[item.name][:quantity] = count_items[item]
      all_items[item.name][:vendors] = vendors_that_sell(item)
    end
    all_items
  end

  def count_items
    item_numbers = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_numbers[item] += quantity
      end
    end
    item_numbers
  end

end
