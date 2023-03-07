require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
  end

  it "exists and has attributes" do
    expect(@vendor1).to be_a(Vendor)
    expect(@vendor1.name).to eq("Rocky Mountain Fresh")
  end

  it "has an inventory which defaults items to stock 0 and has a way to check that stock" do
    expect(@vendor1.inventory).to eq({})
    expect(@vendor1.check_stock(@item1)).to eq(0)
  end

  it "can stock items" do
    @vendor1.stock(@item1, 30)

    expect(@vendor1.inventory).to eq({@item1=>30})
    expect(@vendor1.check_stock(@item1)).to eq(30)
    
    @vendor1.stock(@item1, 25)

    expect(@vendor1.check_stock(@item1)).to eq(55)

    @vendor1.stock(@item2, 12)

    expect(@vendor1.inventory).to eq({@item1=>55, @item2=>12})
  end
end