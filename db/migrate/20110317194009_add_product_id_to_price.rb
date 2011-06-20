class AddProductIdToPrice < ActiveRecord::Migration
  def self.up
    add_column :prices, :product_id, :integer
  end

  def self.down
    remove_column :prices, :product_id
  end
end
