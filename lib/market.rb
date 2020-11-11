require './lib/vendor'

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
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def item_keys
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def total_inventory
    breakdown = Hash[self.item_keys.collect {|item| [item, {quantity: 0, vendors: []}]}]
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        breakdown[item][:quantity] += quantity
        breakdown[item][:vendors] << vendor
      end
    end
    breakdown
  end

end
