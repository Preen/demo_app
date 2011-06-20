class AddProductUrlToPrices < ActiveRecord::Migration
  def self.up
    add_column :prices, :URL, :string
  end

  def self.down
    remove_column :prices, :URL
  end
end
