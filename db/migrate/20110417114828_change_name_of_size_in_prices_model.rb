class ChangeNameOfSizeInPricesModel < ActiveRecord::Migration
  def self.up
    rename_column :prices, :size_id, :product_size_id
  end

  def self.down
    rename_column :prices, :product_size_id, :size_id
  end
end
