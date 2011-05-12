class AddProductUrlToPricesCHangeToSmallCaps < ActiveRecord::Migration
  def self.up
    rename_column :prices, :URL, :url
  end

  def self.down
    rename_column :prices, :url, :URL
  end
end
