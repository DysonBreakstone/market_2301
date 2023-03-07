require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  describe "Instantiation" do
    before(:each) do
      @market1 = Market.new("South Pearl Street Farmers Market")
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: "$0.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    end

    it "exists and has attributes" do
      expect(@market1).to be_a(Market)
      expect(@market1.name).to eq("South Pearl Street Farmers Market")
      expect(@market1.vendors).to eq([])
    end
  end

  describe "Vendor methods" do
    before(:each) do
      @market1 = Market.new("South Pearl Street Farmers Market")
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: "$0.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market1.add_vendor(@vendor1)
      @market1.add_vendor(@vendor2)
      @market1.add_vendor(@vendor3)
    end

    it "can stock vendors with inventories and return their names" do
      expect(@market1.vendors).to eq([@vendor1, @vendor2, @vendor3])
      expect(@market1.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it "can list vendors which sell a particular item" do
      expect(@market1.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market1.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe "Items sold at market" do
    before(:each) do
      @market1 = Market.new("South Pearl Street Farmers Market")
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @item1 = Item.new({name: "Peach", price: "$0.75"})
      @item2 = Item.new({name: "Tomato", price: "$0.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @item5 = Item.new({name: "Pez dispenser", price: "$4.50"})
      @item6 = Item.new({name: "Cow tails", price: "$1.50"})
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor1.stock(@item6, 35)
      @vendor2.stock(@item3, 25)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item6, 35)
      @vendor3.stock(@item1, 65)
      @vendor3.stock(@item5, 80)
      @vendor3.stock(@item2, 13)
      @vendor3.stock(@item4, 20)
      @market1.add_vendor(@vendor1)
      @market1.add_vendor(@vendor2)
      @market1.add_vendor(@vendor3)
    end

    it "can list all items sold" do
      expect(@market1.sorted_item_list).to eq(["Banana Nice Cream", "Cow tails", "Peach", "Peach-Raspberry Nice Cream", "Pez dispenser", "Tomato"])
    end

    it "can list overstocked items" do
      expect(@market1.overstocked_items).to include(@item1, @item6, @item4)
      expect(@market1.overstocked_items).not_to include(@item2, @item3, @item5)
    end

    it "can list total inventory" do
      expect(@market1.total_inventory).to eq({"Peach"=>{quantity: 100, vendors: [@vendor1, @vendor3]},
                                              "Tomato"=>{quantity: 20, vendors: [@vendor1, @vendor3]},
                                              "Peach-Raspberry Nice Cream"=>{quantity: 25, vendors: [@vendor2]},
                                              "Banana Nice Cream"=>{quantity: 70, vendors: [@vendor2, @vendor3]},
                                              "Pez dispenser"=>{quantity: 80, vendors: [@vendor3]},
                                              "Cow tails"=>{quantity: 70, vendors: [@vendor1, @vendor2]}})
    end
  end

  describe "Date and selling items" do
    before(:each) do
      @market1 = Market.new("South Pearl Street Farmers Market")
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @item1 = Item.new({name: "Peach", price: "$0.75"})
      @item2 = Item.new({name: "Tomato", price: "$0.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @item5 = Item.new({name: "Pez dispenser", price: "$4.50"})
      @item6 = Item.new({name: "Cow tails", price: "$1.50"})
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor1.stock(@item6, 35)
      @vendor2.stock(@item3, 25)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item6, 35)
      @vendor3.stock(@item1, 65)
      @vendor3.stock(@item5, 80)
      @vendor3.stock(@item2, 13)
      @vendor3.stock(@item4, 20)
      @market1.add_vendor(@vendor1)
      @market1.add_vendor(@vendor2)
      @market1.add_vendor(@vendor3)
    end

    it "has a date" do
      expect(@market1.date).to eq(Time.now.strftime("%d/%m/%Y"))
    end

    xit "can sell items" do
      expect(@market1.sell(@item2, 1000)).to eq(false)

      @market.sell(@item4, 65)
      @market.sell(@item6, 60)

      expect(@vendor2.inventory[@item4]).to eq(0)
      expect(@vendor3.inventory[@item4]).to eq(5)
      expect(@vendor1.inventory[@item6]).to eq(0)
      expect(@vendor2.inventory[@item6]).to eq(10)
    end
  end
end