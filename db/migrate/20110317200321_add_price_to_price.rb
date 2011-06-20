class AddPriceToPrice < ActiveRecord::Migration
  def self.up
    add_column :prices, :price, :string
  end

  def self.down
    remove_column :prices, :price
  end
end
